import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:runxatruch_app/Widget/calculateDistance.dart';
import 'package:runxatruch_app/bloc/mapa/mapa_bloc.dart';
import 'package:runxatruch_app/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:runxatruch_app/models/events_inscription_model.dart';
import 'package:runxatruch_app/models/route_model.dart';
import 'package:runxatruch_app/pages/cronometer_page.dart';
import 'package:runxatruch_app/pages/map_page.dart';
import 'package:runxatruch_app/provider/events_provider.dart';
import 'package:runxatruch_app/provider/incription_provider.dart';
import 'package:runxatruch_app/provider/user_provider.dart';
import 'package:runxatruch_app/utils/util.dart';

bool _check = false;
bool _start = false;
bool _finish = false;
double distanceMeta = 0;
String _stateRun; //almacena si esta retirado, o finaliza

DateTime timeStart;
DateTime timeEnd;

Timer timer;
Timer timerObjVar;
int starter = 0;
List<LatLng> _route;

class CompetityPage extends StatefulWidget {
  //const CompetityPage({Key key}) : super(key: key);
  @override
  _CompetityPage createState() => _CompetityPage();
}

String categoriaSelect;
EventModelUser data;
dynamic category;
MiUbicacionBloc mapaBloc;

class _CompetityPage extends State<CompetityPage> {
  temp(LatLng ubication, List<LatLng> route, context) {
    if (!_start) {
      double distanceKM = distance(ubication.latitude, ubication.longitude,
          route[0].latitude, route[0].longitude);

      if (distanceKM <= 0.03) {
        _start = true;
        playStop(context);
      }
    } else {
      int end = route.length - 1;
      double distanceKM = distance(ubication.latitude, ubication.longitude,
          route[end].latitude, route[end].longitude);

      distanceMeta = distanceKM;
      if (distanceKM <= 0.03) {
        _start = false;
        playStop(context);
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      timerObjVar = timer;
      temp(mapaBloc.state.ubicacion, _route, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    mapaBloc = BlocProvider.of<MiUbicacionBloc>(context);
    data = ModalRoute.of(context).settings.arguments;

//acceder a la categoria data.categories[0]['km']
    return _bodyCreate(data, context);
  }

  Widget _bodyCreate(EventModelUser data, BuildContext context) {
    // ignore: close_sinks

    final size = MediaQuery.of(context).size;

    return new WillPopScope(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: size.height * 0.14,
              margin: EdgeInsets.only(top: size.height * 0.05),
              child: Column(
                children: <Widget>[
                  TimerTextWidget(),
                  Text('Duración',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent)),

                  SizedBox(
                    height: 5,
                  ),
                  //_createInformation()
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: size.height * 0.04,
                child: _information()),
            Container(
                width: size.width * 1,
                height: size.height * 0.77,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset.zero, //(x,y)
                        blurRadius: 2.0,
                      )
                    ]),
                child: _createMap(data.categories, context))
          ],
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.only(left: 27),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                elevation: 0.0,
                backgroundColor: Colors.white,
                onPressed: () => newTheme(context),
                child: Icon(Icons.layers_outlined, color: Colors.red[400]),
              ),
              _btnStart(context),
              _btnRemove(context, data),
            ],
          ),
        ),
      ),
      onWillPop: () async => false,
    );
  }

  Widget _btnStart(BuildContext context) {
    return RaisedButton(
      child: Container(
          width: 85.0,
          height: 55,
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_check ? Text('Finalizar') : Text('Iniciar')],
          )),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
      elevation: 5.0,
      color: Colors.red[400],
      textColor: Colors.white,
      onPressed: () => playStop(context),
    );
  }

  Widget _btnRemove(BuildContext context, EventModelUser data) {
    return RaisedButton(
      child: Container(
          width: 85.0,
          height: 55,
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('Retirarme')],
          )),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
      elevation: 5.0,
      color: Colors.red[400],
      textColor: Colors.white,
      onPressed: () => {_stateRun = 'Retirado', _end(context, data)},
    );
  }

  _end(BuildContext context, EventModelUser data) {
    //var timeTotal = ......................
    var dataRun = {
      "kmTours": TimerTextWidget().distance(context),
      "timeTotal": TimerTextWidget().time(context),
      "timeStart": timeStart,
      "timeEnd": timeEnd,
      "state": _stateRun
    };
    if (_stateRun == 'Retirado') {
      int count = 0;
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('¿Realmente desea retirarse de la carrera?'),
              actions: <Widget>[
                FlatButton(
                  child: Text('No', style: TextStyle(color: Colors.red[400])),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('Sí', style: TextStyle(color: Colors.red[400])),
                  onPressed: () async {
                    setState(() {
                      _check = false;
                    });

                    await UserProvider()
                        .saveRouteCompetence(data, dataRun, context);
                    cancelTimer();

                    Navigator.popUntil(context, (route) {
                      return count++ == 2;
                    });
                  },
                )
              ],
            );
          });
    }
  }

  Widget _information() {
    if (_check) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Text(
              "KM restantes: ",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red[400],
                  fontSize: 20),
            ),
            Text(
              distanceMeta == 0
                  ? "  -- "
                  : "${distanceMeta.toStringAsPrecision(2)}",
              style: TextStyle(fontSize: 20),
            ),
          ]),
          Text(
            "KM/H",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red[400],
                fontSize: 20),
          )
        ],
      );
    } else {
      return Text("Para iniciar cruce la linea de salida",
          style: TextStyle(
            color: Colors.red[400],
          ));
    }
  }

  playStop(BuildContext context) {
    print(_check);
    if (_check == true) {
      print("finalizao");
      cancelTimer();
      timeEnd = DateTime.now();
      final bool value = stopResumen(true, context);

      showAbstractRun({
        "km": TimerTextWidget().distance(context),
        "time": TimerTextWidget().time(context),
        "velocidad": TimerTextWidget().velocity(context)
      }, context);
      TimerTextWidget().reset(context);

      setState(() {
        _check = !_check;
      });
    } else if (_check == false) {
      timeStart = DateTime.now();
      final bool value = startResumen(context);
      if (!value) {
        TimerTextWidget().startTime(context);
        setState(() {
          _check = !_check;
        });
      }
    }
  }

  //Generar mapa con la ruta
  Widget _createMap(id, context) {
    List<LatLng> route = [];
    return FutureBuilder(
      future: EventProvider().category(id[0]['id']),
      builder: (BuildContext context, AsyncSnapshot<RuteModel> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          route.clear();

          for (var item in data.rute) {
            if (item["log"] != null || item["lat"] != null) {
              LatLng ite = new LatLng(double.parse(item["lat"].toString()),
                  double.parse(item["log"].toString()));
              route.add(ite);
            }
          }
          _route = route;

          return Container(
            child: MapPage(
              route: route,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  cancelTimer() {
    if (timer != null) {
      print(timer);
      timer.cancel();
      timer = null;
    }
    if (timerObjVar != null) {
      print(timerObjVar);
      timerObjVar.cancel();
      timerObjVar = null;
    }
  }
}
