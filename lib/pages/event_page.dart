import 'package:flutter/material.dart';
import 'package:runxatruch_app/models/events_model.dart';

class EventPage extends StatelessWidget {
  const EventPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EventModel data = ModalRoute.of(context).settings.arguments;
    print(data.categories);
    return Scaffold(
      appBar: AppBar(
        title: Text(data.nameEvent),
      ),
      body: Center(
        child: Text(data.nameEvent),
      ),
    );
  }
}
