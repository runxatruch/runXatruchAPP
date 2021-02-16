import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      _pref.credential = {
        'email': userCredential.user.email,
        'uid': userCredential.user.uid
      }.toString();
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
          _pref.credential =
              {'email': result.user.email, 'uid': result.user.uid}.toString();
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

  Future<Map<String, dynamic>> _getDataUser(String email) async {
    _competitor.where('email', isEqualTo: email).get().then((value) {
      value.docs.forEach((result) {
        final user = UserModel.fromJson(result.data());
        return {'data', user.toJson()};
      });
    });
  }
}
