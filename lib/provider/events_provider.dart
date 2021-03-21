import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:runxatruch_app/models/events_model.dart';
import 'package:runxatruch_app/prefUser/preferent_user.dart';

class EventProvider {
  final _pref = PreferenciasUsuario();
  final firestoreInstance = FirebaseFirestore.instance;

  Future<List<EventModel>> getEvents() async {
    Query firestoreInstance = FirebaseFirestore.instance.collection("event");
    final List<EventModel> events = new List();
    await firestoreInstance.get().then((value) {
      value.docs.forEach((result) {
        final value = EventModel.fromJson(result.data());
        events.add(value);
      });
    });
    print(events[1].city);
    return events;
  }
}
