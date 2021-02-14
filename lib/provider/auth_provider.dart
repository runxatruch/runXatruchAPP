import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:runxatruch_app/models/account_models.dart';

class AuthProvider {
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference _competitor =
      FirebaseFirestore.instance.collection('competitor');

  Future loginUser(String email, String password) async {
    final result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future registerUser(CuentaModel userData) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: userData.email, password: userData.password);
      print("token: ${result.credential}");
      final result2 = await _addCompetitor(userData);
      return result.user;
    } catch (e) {
      print('Error');
      print(e.toString());
      return null;
    }
  }

  Future _addCompetitor(CuentaModel userData) async {
    return await _competitor
        .add({
          'firstName': userData.nombres,
          'lastName': userData.apellidos,
          'email': userData.email,
          'location': userData.ciudad,
          'number': userData.telefono,
          'birthDate': userData.fechaNac
        })
        .then((value) => print('Competidor agregado cone xito'))
        .catchError((e) => print("error $e"));
  }
}
