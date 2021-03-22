import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:runxatruch_app/models/events_model.dart';
import 'package:runxatruch_app/prefUser/preferent_user.dart';

class EventProvider {
  final _pref = PreferenciasUsuario();
  final firestoreInstance = FirebaseFirestore.instance;

  Future<List<EventModel>> getEvents() async {
    Query firestoreInstance = FirebaseFirestore.instance.collection("event");
    final List<EventModel> events = new List();

    await firestoreInstance
        .where("startTime", isLessThanOrEqualTo: monthNext())
        .where("startTime", isGreaterThanOrEqualTo: DateTime.now().toString())
        .get()
        .then((value) {
      value.docs.forEach((result) {
        final value = EventModel.fromJson(result.data());

        events.add(value);
        //print(value.startTime);
      });
    });

    return events;
  }

  // getMonthYear(date) {
  //   var subsY = date.substring(0, 4);
  //   var subsM = date.substring(5, 7);
  //   String conct = subsM + "." + subsY;
  //   return conct;
  // }

  // getMonthYearNow(date) {
  //   var formatter = new DateFormat('MM-yyyy-dd');
  //   String monthYear = formatter.format(date);
  //   return monthYear;
  // }

  monthNext() {
    var now = new DateTime.now();
    var datePost = new DateTime(now.year, now.month + 1, now.day);
    String date = datePost.toString();
    return date;
  }
}
