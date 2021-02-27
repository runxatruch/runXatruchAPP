//import 'package:runxatruch_app/pages/account_pages.dart';

//verificando que sean tipo numerico

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:runxatruch_app/bloc/mapa/mapa_bloc.dart';
import 'package:runxatruch_app/models/trainingUser_model.dart';
import 'package:runxatruch_app/provider/user_provider.dart';

bool isNumeric(String s) {
  if (s.isEmpty) return false;

  final n = num.tryParse(s);

  return (n == null) ? false : true;
}

//verificando correo

RegExp regExp = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

bool validatorEmail(String c) {
  if (regExp.hasMatch(c)) {
    return true;
  } else {
    return false;
  }
}

//verificar cantidad de caracteres de identidad

bool identity(String id) {
  RegExp idenExp = RegExp(r'^([01][1-8][0-2][1-9]\d{9})$');
  if (idenExp.hasMatch(id)) {
    return true;
  } else {
    return false;
  }
}

//verificar telefono
bool numberTel(String tel) {
  if (tel.length < 8 || !isNumeric(tel.substring(0))) {
    return false;
  } else {
    return true;
  }
}

//validar clave
RegExp regExp2 = RegExp(r'^(?=\w*\d)(?=\w*[A-Z])(?=\w*[a-z])\S{8,16}$');

bool passwordValid(String pass) {
  if (!regExp2.hasMatch(pass)) {
    return false;
  } else {
    return true;
  }
}

newTheme(BuildContext context) {
  // ignore: close_sinks
  final mapaBloc = BlocProvider.of<MapaBloc>(context);
  mapaBloc.add(OnNewTheme());
}

bool stopResumen(bool state, BuildContext context) {
  // ignore: close_sinks
  final mapaBloc = BlocProvider.of<MapaBloc>(context);
  mapaBloc.add(OnMarcarRecorrido());
  return mapaBloc.state.dibujarRecorrido;
}

bool startResumen(BuildContext context) {
  // ignore: close_sinks
  final mapaBloc = BlocProvider.of<MapaBloc>(context);
  mapaBloc.add(OnMarcarRecorrido());
  return mapaBloc.state.dibujarRecorrido;
}

showAbstract(Map<String, dynamic> data, BuildContext context) {
  // ignore: close_sinks
  final mapaBloc = BlocProvider.of<MapaBloc>(context);
  final TrainingModel training = new TrainingModel();
  training.km = data['km'];
  training.speed = data['velocidad'];
  training.time = data['time'];
  final temp = [];
  for (var item in mapaBloc.state.polylines.values.first.points) {
    temp.add({"Lat": item.latitude, "Log": item.longitude});
  }
  training.polylines = temp;
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Resumen'),
          content: Container(
            height: 180,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Km recorridos: ',
                ),
                Text('${data['km']}', style: TextStyle(fontSize: 25)),
                Divider(),
                Text(
                  'Velociadad promedio: ',
                ),
                Text('${data['velocidad']} km/h',
                    style: TextStyle(fontSize: 25)),
                Divider(),
                Text('Tiempo total:'),
                Text('${data['time']}', style: TextStyle(fontSize: 25)),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancelar', style: TextStyle(color: Colors.red[400])),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text('Guardar', style: TextStyle(color: Colors.red[400])),
              onPressed: () {
                UserProvider().saveRouteUser(training);
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}
