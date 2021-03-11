import 'package:flutter/material.dart';

void mostrarAlerta(BuildContext context, Map<dynamic, dynamic> mensaje) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Alerta'),
          content: Text(mensaje['msj']),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Ok',
                style: TextStyle(color: Colors.red[400]),
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      });
}
