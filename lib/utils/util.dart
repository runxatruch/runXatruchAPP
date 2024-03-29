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
RegExp regExp2 = RegExp(r'^(?=\w*\d)(?=\w*[a-z])\S{8,16}$');

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
  try {
    mapaBloc.add(OnNewTheme());
  } catch (e) {}
}

Widget tempWidget(BuildContext context) {
  // ignore: close_sinks
  final mapaBloc = BlocProvider.of<MapaBloc>(context);
  return Container(
    child: Text('${mapaBloc}'),
  );
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
          title: Text('Resumen:',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent)),
          content: Container(
            height: 190,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Km recorridos: ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                Text('${data['km']}',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                Divider(),
                Text('Velocidad promedio: ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                Text('${data['velocidad']} km/h',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                Divider(),
                Text('Tiempo total: mm:ss',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                Text('${data['time']}',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
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

showAbstractRun(Map<String, dynamic> data, BuildContext context) {
  int count = 0;
  // ignore: close_sinks
  final TrainingModel training = new TrainingModel();
  training.time = data['time'];

  showDialog(
      context: context,
      barrierColor: Colors.redAccent,
      barrierDismissible: false,
      builder: (context) {
        return new WillPopScope(
          child: AlertDialog(
            elevation: 50.0,
            title: Text('LLego a la Meta:',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent)),
            content: Container(
              height: 180,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(children: [
                    Icon(
                      Icons.run_circle_sharp,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Km recorridos: ',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey)),
                  ]),
                  Text('${data['km']}',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  Divider(),
                  Row(children: [
                    Icon(
                      Icons.run_circle_sharp,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Tiempo total: mm:ss',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey))
                  ]),
                  Text('${data['time']}',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Salir del evento',
                    style: TextStyle(color: Colors.red[400])),
                onPressed: () {
                  //UserProvider().saveRouteUser(training);
                  Navigator.pushNamedAndRemoveUntil(context, "home", (route) {
                    return count++ == 3;
                  });
                },
              )
            ],
          ),
          onWillPop: () async => false,
        );
      });
}
