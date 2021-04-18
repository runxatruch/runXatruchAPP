import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:runxatruch_app/prefUser/preferent_user.dart';

CollectionReference _inscription =
    FirebaseFirestore.instance.collection('userInscription');

class InscriptionProvider {
  final _pref = PreferenciasUsuario();

  addInscription(Map data) async {
    bool _exist;
    final preferences = jsonDecode(_pref.credential);
    data['idUser'] = preferences['uid'];
    final firestoreInstance = FirebaseFirestore.instance;
    //aca tengo que  verificar si ya hay un registro de evento y usuario en el que la fecha de evento sea igual
    try {
      await firestoreInstance
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
      //agregar condicion de si ya esta inscrito
      if (_exist == false) {
        firestoreInstance.collection("userInscription").add(data).then((value) {
          // print(value.id);
          // showDialog(
          //     context: context,
          //     builder: (buildcontext) {
          //       return AlertDialog(
          //         title: Text("FELICIDADES"),
          //         content: Text("Inscrito correctamente"),
          //         actions: <Widget>[
          //           GestureDetector(
          //             child: Text(
          //               "CERRAR",
          //               style: TextStyle(color: Colors.red),
          //             ),
          //             onTap: () {
          //               // Navigator.of(context).pop();
          //               Navigator.pushReplacementNamed(context, 'home');
          //             },
          //           )
          //         ],
          //       );
          //     });
        });
        return {"ok": true};
      } else {
        // showDialog(
        //     context: context,
        //     builder: (buildcontext) {
        //       return AlertDialog(
        //         title: Text("Error"),
        //         content: Text("Ya se encuentra inscrito en este evento"),
        //         actions: <Widget>[
        //           GestureDetector(
        //             child: Text(
        //               "CERRAR",
        //               style: TextStyle(color: Colors.red),
        //             ),
        //             onTap: () {
        //               Navigator.of(context).pop();
        //               //Navigator.pushReplacementNamed(context, 'home');
        //             },
        //           )
        //         ],
        //       );
        //     });
        return {"ok": false, "msj": "Ya estas incrito a este evento"};
      }
    } catch (e) {
      return {"ok": false, "msj": e};
    }
  }

  Future<bool> deleteUser(String id) async {
    try {
      await _inscription.doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
