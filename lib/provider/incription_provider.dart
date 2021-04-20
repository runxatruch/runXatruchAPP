import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:runxatruch_app/models/events_model.dart';
import 'package:runxatruch_app/prefUser/preferent_user.dart';

CollectionReference _inscription =
    FirebaseFirestore.instance.collection('userInscription');
final _pref = PreferenciasUsuario();
final firestoreInstance = FirebaseFirestore.instance;

class InscriptionProvider {
  addInscription(Map data) async {
    bool _exist;
    final preferences = jsonDecode(_pref.credential);
    data['idUser'] = preferences['uid'];
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

  Future<List<Map<dynamic, dynamic>>> showPartipation() async {
    List<Map<dynamic, dynamic>> listRunning = [];
    final preferences = jsonDecode(_pref.credential);
    final uid = preferences['uid'];
    final listInscription = await showInscription(uid);
    for (var item in listInscription) {
      final resp = await showRunningUser(item["id"]);
      if (resp != null) {
        final event = await setEvent(item["idEvent"]);
        final running = resp;
        listRunning.add({
          ...running,
          "nameEvent": event.nameEvent,
          "date": event.startTime
        });
      }
    }
    return listRunning;
  }

  Future<List> showInscription(uid) async {
    List inscripciones = [];
    await firestoreInstance
        .collection("userInscription")
        .where("idUser", isEqualTo: uid)
        .orderBy("date", descending: false)
        .get()
        .then((inscription) => {
              for (var item in inscription.docs)
                {
                  inscripciones.add({...item.data(), "id": item.id})
                }
            });
    return inscripciones;
  }

  Future<EventModel> setEvent(id) async {
    EventModel event;
    await firestoreInstance
        .collection("event")
        .where("id", isEqualTo: id)
        .get()
        .then((inscription) => {
              for (var item in inscription.docs)
                {event = EventModel.fromJson(item.data())}
            });
    return event;
  }

  Future<Map<dynamic, dynamic>> showRunningUser(id) async {
    Map<dynamic, dynamic> runing;
    await firestoreInstance
        .collection("competenceRunning")
        .where("idInscription", isEqualTo: id)
        .get()
        .then((inscription) => {
              if (inscription.docs.length > 0)
                {runing = inscription.docs[0].data()}
              else if (inscription.docs.length == 0)
                {runing = null}
            });
    return runing;
  }
}
