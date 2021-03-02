import 'package:flutter/material.dart';

class ParticipationsPage extends StatelessWidget {
  const ParticipationsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List producto = new List();
    final podData = ModalRoute.of(context).settings.arguments;
    if (podData != null) {
      producto = podData;
      print(producto);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Participaciones'),
      ),
    );
  }
}
