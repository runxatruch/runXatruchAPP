import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:runxatruch_app/models/user_models.dart';
import 'package:runxatruch_app/provider/events_provider.dart';
import 'package:runxatruch_app/models/events_model.dart';

class CareersPages extends StatelessWidget {
  const CareersPages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pro = EventProvider();
    final Future<List<EventModel>> events = pro.getEvents();
    //final int age = pro.getAgeNac();
    //print(fecha);

    //print(events);

    return Scaffold(
      body: Center(child: Text('Carreras')),
    );
  }
}
