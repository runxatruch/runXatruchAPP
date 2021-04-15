import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:runxatruch_app/models/events_inscription_model.dart';
import 'package:runxatruch_app/models/events_model.dart';
import 'package:runxatruch_app/models/user_models.dart';
import 'package:runxatruch_app/models/route_model.dart';
import 'package:runxatruch_app/prefUser/preferent_user.dart';

class EventProvider {
  final _pref = PreferenciasUsuario();
  final firestoreInstance = FirebaseFirestore.instance;

  Future<List<EventModel>> getEvents() async {
    final List<EventModel> events = new List();
    final data = jsonDecode(_pref.credential);
    List eventIncription = [];
    int ageUser;
//Instancia coleccion users para saber su edad
    Query firestoreInstanceU = FirebaseFirestore.instance.collection("users");

    await firestoreInstanceU
        .where("email", isEqualTo: data['email'])
        .get()
        .then((value) {
      value.docs.forEach((result) {
        final user = UserModel.fromJson(result.data());
        //print(user);
        final id = result.id;
        user.id = id;
        int subsY = int.parse(user.fechaNac.substring(0, 4));
        var dateNow = DateTime.now();
        var anioActual = dateNow.year;
        ageUser = anioActual - subsY;
      });
    });

//Intancia coleccion evento
    Query firestoreInstance = FirebaseFirestore.instance.collection("event");

    //obteniendo las categorias existentes
    await getInscription(data['uid']).then((value) {
      value.docs.forEach((result) {
        eventIncription.add(result.data()['idEvent']);
      });
    });

    await firestoreInstance
        .where("startTime", isLessThanOrEqualTo: monthNext())
        .where("startTime", isGreaterThanOrEqualTo: DateTime.now().toString())
        .orderBy("startTime")
        .get()
        .then((value) {
      value.docs.forEach((result) {
        final value = EventModel.fromJson(result.data());
        bool validate = false;
        bool inscrito = false;
        eventIncription.forEach((e) {
          if (e == value.id) inscrito = true;
        });
        if (!inscrito) {
          value.categories.forEach((element) {
            //final d = element['rangeEge'];
            var idCat = element['id'];

            int ageMin = int.parse(element['ageMin']);
            int ageMax = int.parse(element['ageMax']);
            if (ageUser >= ageMin && ageUser <= ageMax) {
              //return cuando ya se encuentre una categoria con esa edad
              validate = true;
              element['admitido'] = true;
            } else {
              element['admitido'] = false;
            }
          });
        }

        if (validate == true &&
            DateTime.now().isBefore(DateTime.parse(value.inscriptionTime))) {
          events.add(value);
        }
      });
    });

    return events;
  }

  monthNext() {
    var now = new DateTime.now();
    var datePost = new DateTime(now.year, now.month + 1, now.day);
    String date = datePost.toString();
    return date;
  }

  Future<RuteModel> category(String id) async {
    RuteModel categories = new RuteModel();

    Query firestoreInstanceRoute =
        FirebaseFirestore.instance.collection("category");
    await firestoreInstanceRoute
        .where("id", isEqualTo: id)
        .get()
        .then((valueCat) {
      valueCat.docs.forEach((element) {
        categories.id = element.id;
        categories.rute = element['rute'];
      });
    });
    return categories;
  }

  Future<List<EventModelUser>> getEventsInscription() async {
    final List<EventModelUser> eventsUser = new List();
    final data = jsonDecode(_pref.credential);

    String idUser;
//Instancia coleccion users para saber su edad
    Query firestoreInstanceU = FirebaseFirestore.instance.collection("users");

    await firestoreInstanceU
        .where("email", isEqualTo: data['email'])
        .get()
        .then((value) {
      value.docs.forEach((result) {
        final user = UserModel.fromJson(result.data());
        //print(user);
        final id = result.id;
        idUser = id;
        user.id = id;
      });
    });
//Instancia coleccion userInscription para saber los eventos a los que esta inscrito
    List events = [];
    List listid = [];
    String idInscriptionUser;
    Query firestoreInstanceUI =
        FirebaseFirestore.instance.collection("userInscription");

    await firestoreInstanceUI
        .where("idUser", isEqualTo: idUser)
        .get()
        .then((value) {
      value.docs.forEach((result) {
        events
            .add({'idEvent': result['idEvent'], 'idCat': result['idCategory']});
        listid.add(result.id);

        idInscriptionUser = result.id;
      });
    });

//Intancia coleccion evento
    Query firestoreInstance = FirebaseFirestore.instance.collection("event");
    print('*********************');
    String dateNow = (DateTime.now().toString().substring(0, 10) +
        'T' +
        DateTime.now().toString().substring(11, 16));
    //obteniendo las categorias existentes
    for (var i = 0; i < events.length; i++) {
      await firestoreInstance
          .where("id", isEqualTo: events[i]['idEvent'])
          //.where("endTime", isLessThanOrEqualTo: '2021-05-01T12:00')
          .get()
          .then((value) {
        value.docs.forEach((result) {
          final value = EventModelUser.fromJson(result.data());

          value.idInscription = listid[i];
          //print("value id ${value.idInscription}");
          value.categories.forEach((element) {
            if (element['id'] == events[i]['idCat']) {
              element['inscrito'] = true;
            } else {
              element['inscrito'] = false;
            }
          });
          if (DateTime.now().isBefore(DateTime.parse(value.endTime))) {
            eventsUser.add(value);
          }
        });
      });
    }

    return eventsUser;
  }

  Future getInscription(String uid) async {
    Query instanceInscription =
        FirebaseFirestore.instance.collection("userInscription");
    return await instanceInscription.where("idUser", isEqualTo: uid).get();
  }
}
