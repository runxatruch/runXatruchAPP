import 'package:flutter/material.dart';

void mostrarAlerta(BuildContext context, Map<dynamic, dynamic> mensaje) {
  int count = 0;
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
              onPressed: () {
                !mensaje['route']
                    ? Navigator.of(context).pop()
                    : Navigator.popUntil(context, (route) {
                        return count++ == 2;
                      });
              },
            )
          ],
        );
      });
}
