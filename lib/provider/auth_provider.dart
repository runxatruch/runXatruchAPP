import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:runxatruch_app/models/user_models.dart';

class AuthProvider {
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference _competitor =
      FirebaseFirestore.instance.collection('users');

  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return {'ok': false, 'error': 'No existe correo electronico'};
      } else if (e.code == 'wrong-password') {
        return {'ok': false, 'error': 'Contraseña incorrecra'};
      }
    }
    return {'ok': true, 'credential': UserCredential};
  }

  //Registrar un nuevo usuario
  Future<Map<String, dynamic>> registerUser(UserModel userData) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: userData.email, password: userData.password);
      if (result.user.uid != null) {
        await _addCompetitor(userData);
      }
      return {'ok': false, 'credential': result.user};
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
