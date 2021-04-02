import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

CollectionReference _inscription =
    FirebaseFirestore.instance.collection('userInscription');

class InscriptionProvider {
//recibir argumento el model
  // Future<Map<String, dynamic>> addInscription() async {
  //   await _registerInscription();
  //   return {'ok': true}; //recibir user data
  // }
  var _exist;

  addInscription(BuildContext context, Map data) {
    DateTime date = DateTime.parse("2021-04-15T15:30");
    final firestoreInstance = FirebaseFirestore.instance;
    //aca tengo que  verificar si ya hay un registro de evento y usuario en el que la fecha de evento sea igual
    firestoreInstance
        .collection("userInscription")
        .where("idEvent", isEqualTo: data['idEvent'])
        .where("idUser", isEqualTo: data['idUser'])
        .get()
        .then((value) {
      if (value.size > 0) {
        _exist = true;
      } else {
        _exist = false;
      }
    });
    //probar en poner en if el exist...
    print(_exist);
    //agregar condicion de si ya esta inscrito
    if (_exist == false) {
      firestoreInstance.collection("userInscription").add(data).then((value) {
        print(value.id);
        showDialog(
            context: context,
            builder: (buildcontext) {
              return AlertDialog(
                title: Text("FELICIDADES"),
                content: Text("Inscrito correctamente"),
                actions: <Widget>[
                  GestureDetector(
                    child: Text(
                      "CERRAR",
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () {
                      // Navigator.of(context).pop();
                      Navigator.pushReplacementNamed(context, 'home');
                    },
                  )
                ],
              );
            });
      });
    } else {
      showDialog(
          context: context,
          builder: (buildcontext) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Ya se encuentra inscrito en este evento"),
              actions: <Widget>[
                GestureDetector(
                  child: Text(
                    "CERRAR",
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    //Navigator.pushReplacementNamed(context, 'home');
                  },
                )
              ],
            );
          });
    }
  }

  //como parametro debo recibir el model
  Future _registerInscription() async {
    Map userData = {
      "idUser": 'idU',
      "idEvent": 'idE',
      "idCategory": 'idC',
      "date": DateTime.now()
    };
    return await _inscription
        //.add(userData.toJson()) reemplazar cuando tenga el data como argumento
        .add(userData)
        .then((value) => print('Competidor agregado con éxito'))
        .catchError((e) => print("error $e"));
  }
}
