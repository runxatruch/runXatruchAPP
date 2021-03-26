import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:runxatruch_app/models/events_model.dart';
import 'package:runxatruch_app/models/user_models.dart';
import 'package:runxatruch_app/pages/porfile_page.dart';
import 'package:runxatruch_app/prefUser/preferent_user.dart';
import 'package:runxatruch_app/provider/user_provider.dart';

class EventProvider {
  final _pref = PreferenciasUsuario();
  final firestoreInstance = FirebaseFirestore.instance;

  Future<List<EventModel>> getEvents() async {
    final List<EventModel> events = new List();
    final data = jsonDecode(_pref.credential);
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

    await firestoreInstance
        .where("startTime", isLessThanOrEqualTo: monthNext())
        .where("startTime", isGreaterThanOrEqualTo: DateTime.now().toString())
        .get()
        .then((value) {
      value.docs.forEach((result) {
        final value = EventModel.fromJson(result.data());
        bool validate = false;

        value.categories.forEach((element) {
          //final d = element['rangeEge'];
          var idCat = element['id'];

          int ageMin = int.parse(element['ageMin']);
          int ageMax = int.parse(element['ageMax']);
          //print(element);

          // categories.forEach((elementCat) {
          //   final dataC = jsonDecode(elementCat);
          //   if (dataC['id'] == idCat) {
          //     element['ruteArray'] = dataC['rute'];
          //   }
          // });
          if (ageUser >= ageMin && ageUser <= ageMax) {
            //return cuando ya se encuentre una categoria con esa edad
            validate = true;
          }
        });
        if (validate == true) {
          events.add(value);
        }
      });
    });
    //print(events.length);
    // Future<List> cat = category("0bvPah3DhO6LDTTLh1DY");
    // print(cat.then((value) => print(value)));

    return events;
  }

  monthNext() {
    var now = new DateTime.now();
    var datePost = new DateTime(now.year, now.month + 1, now.day);
    String date = datePost.toString();
    return date;
  }

  Future<List> category(String id) async {
    final categories = [];

    Query firestoreInstanceRoute =
        FirebaseFirestore.instance.collection("category");
    await firestoreInstanceRoute
        .where("id", isEqualTo: id)
        .get()
        .then((valueCat) {
      valueCat.docs.forEach((element) {
        final data = {"id": element.id, "rute": element['rute']};
        //print(element['nameCategory']);
        categories.add(jsonEncode(data));
      });
    });
    return categories;
  }
}
