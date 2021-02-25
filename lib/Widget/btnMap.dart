import 'package:flutter/material.dart';

class BTNmap extends StatefulWidget {
  const BTNmap({Key key}) : super(key: key);

  @override
  _BTNmapState createState() => _BTNmapState();
}

bool _check = false;

class _BTNmapState extends State<BTNmap> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RaisedButton(
          child: Container(
              width: 95.0,
              height: 55,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [_check ? Text('Finalizar') : Text('Iniciar')])),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
          elevation: 5.0,
          color: Colors.lightBlue[800],
          textColor: Colors.white,
          onPressed: () => _playStop(),
        )
      ],
    );
  }

  _playStop() {
    setState(() {
      _check = !_check;
    });
  }
}