import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:runxatruch_app/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:runxatruch_app/models/events_inscription_model.dart';
import 'package:runxatruch_app/pages/cronometer_page.dart';
import 'package:runxatruch_app/pages/map_page.dart';
import 'package:runxatruch_app/provider/incription_provider.dart';
import 'package:runxatruch_app/provider/user_provider.dart';
import 'package:runxatruch_app/utils/util.dart';

bool _check = false;
String _stateRun; //almacena si esta retirado, o finaliza

DateTime timeStart;
DateTime timeEnd;

class CompetityPage extends StatefulWidget {
  //const CompetityPage({Key key}) : super(key: key);

  @override
  _CompetityPage createState() => _CompetityPage();
}

String categoriaSelect;
EventModelUser data;
dynamic category;

class _CompetityPage extends State<CompetityPage> {
  final _inscriptionProvider = new InscriptionProvider();
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    // ignore: close_sinks
    final mapaBloc = BlocProvider.of<MiUbicacionBloc>(context);
    print('tamanio ${mapaBloc.state.ubicacion}');
//acceder a la categoria data.categories[0]['km']
    return _bodyCreate(data, context);
  }

  Widget _bodyCreate(EventModelUser data, BuildContext context) {
    final size = MediaQuery.of(context).size;
    print(data.categories);
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
                width: size.width * 1,
                height: size.height * 0.81,
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
                child: MapPage())
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
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('¿Realmente desea retirarse de la carrera?'),
              actions: <Widget>[
                FlatButton(
                  child: Text('No', style: TextStyle(color: Colors.red[400])),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                FlatButton(
                  child: Text('Sí', style: TextStyle(color: Colors.red[400])),
                  onPressed: () {
                    _check = false;
                    UserProvider().saveRouteCompetence(data, dataRun, context);
                    Navigator.pushNamed(context, 'home');
                  },
                )
              ],
            );
          });
    }
  }

  playStop(BuildContext context) {
    if (_check == true) {
      timeStart = DateTime.now();
      _stateRun = 'Corriendo';
      final bool value = stopResumen(true, context);
      if (value) {
        showAbstractRun({
          "km": TimerTextWidget().distance(context),
          "time": TimerTextWidget().time(context),
          "velocidad": TimerTextWidget().velocity(context)
        }, context);
        TimerTextWidget().reset(context);

        setState(() {
          _check = !_check;
        });
      }
    } else if (_check == false) {
      timeEnd = DateTime.now();
      final bool value = startResumen(context);
      if (!value) {
        TimerTextWidget().startTime(context);
        setState(() {
          _check = !_check;
        });
      }
    }
  }
}
