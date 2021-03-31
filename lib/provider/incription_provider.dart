import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference _inscription =
    FirebaseFirestore.instance.collection('userInscription');

class AuthProvider {
  Map userData = {
    "idUser": 'idU',
    "idEvent": 'idE',
    "idCategory": 'idC',
    "date": DateTime.now()
  };
  //como parametro debo recibir el model
  Future addInscription() async {
    return await _inscription
        //.add(userData.toJson()) reemplazar cuando tenga el data como argumento
        .add(userData)
        .then((value) => print('Competidor agregado con éxito'))
        .catchError((e) => print("error $e"));
  }
}
