import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:runxatruch_app/models/user_models.dart';
import 'package:runxatruch_app/prefUser/preferent_user.dart';

class AuthProvider {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _pref = new PreferenciasUsuario();
  CollectionReference _competitor =
      FirebaseFirestore.instance.collection('users');

  Future<Map<String, dynamic>> loginUser(
      String email, String password, bool temp) async {
    UserCredential userCredential;
    try {
      userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return {'ok': false, 'error': 'No existe correo electronico'};
      } else if (e.code == 'wrong-password') {
        return {'ok': false, 'error': 'Contraseña incorrecra'};
      }
    }
    if (temp) {
      final data = {
        "email": userCredential.user.email,
        "uid": userCredential.user.uid,
        "mantener": true
      };
      _pref.credential = jsonEncode(data);
    } else {
      final data = {
        "email": userCredential.user.email,
        "uid": userCredential.user.uid,
        "mantener": false
      };
      _pref.credential = jsonEncode(data);
    }

    return {'ok': true, 'credential': userCredential};
  }

  //Registrar un nuevo usuario
  Future<Map<String, dynamic>> registerUser(
      UserModel userData, bool temp) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: userData.email, password: userData.password);
      if (result.user.uid != null) {
        await _addCompetitor(userData);
        if (temp) {
          final data = {
            "email": result.user.email,
            "uid": result.user.uid,
            "mantener": true
          };
          _pref.credential = jsonEncode(data);
        } else {
          final data = {
            "email": result.user.email,
            "uid": result.user.uid,
            "mantener": false
          };
          _pref.credential = jsonEncode(data);
        }
        return {'ok': true, 'credential': result};
      }
      return {'ok': false, 'credential': result};
    } catch (e) {
      return {'ok': false, 'error': e.code};
    }
  }

  Future _addCompetitor(UserModel userData) async {
    return await _competitor
        .add(userData.toJson())
        .then((value) => print('Competidor agregado cone xito'))
        .catchError((e) => print("error $e"));
  }

  Future<List<UserModel>> getDataUser() async {
    final data = jsonDecode(PreferenciasUsuario().credential);
    final firestoreInstance = FirebaseFirestore.instance;
    final mantener = data['mantener'];
    final List<UserModel> dataUser = new List();
    await firestoreInstance
        .collection("users")
        .where("email", isEqualTo: data['email'])
        .get()
        .then((value) {
      value.docs.forEach((result) {
        print(result.data());
        final user = UserModel.fromJson(result.data());
        final id = result.id;
        user.id = id;
        
        final data = {"email": user.email, "uid": user.id,"mantener":mantener};
        _pref.credential = jsonEncode(data);
        dataUser.add(user);
      });
    });

    return dataUser;
  }
}
