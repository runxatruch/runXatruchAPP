import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:runxatruch_app/Widget/calculateDistance.dart';
import 'package:runxatruch_app/models/events_inscription_model.dart';
import 'package:runxatruch_app/pages/historial_training.dart';
import 'package:runxatruch_app/pages/map_page.dart';
import 'package:runxatruch_app/provider/incription_provider.dart';
import 'package:runxatruch_app/provider/user_provider.dart';
import 'package:runxatruch_app/utils/util.dart';
import 'timer.dart';

bool _check = false;
String _stateRun; //almacena si esta retirado, o finaliza

final timerProvider = StateNotifierProvider<TimerNotifier>(
  (ref) => TimerNotifier(),
);

final _buttonState = Provider<ButtonState>((ref) {
  return ref.watch(timerProvider.state).buttonState;
});

final buttonProvider = Provider<ButtonState>((ref) {
  return ref.watch(_buttonState);
});

final state = useProvider(buttonProvider);

final _timeLeftProvider = Provider<String>((ref) {
  return ref.watch(timerProvider.state).timeLeft;
});

final timeLeftProvider = Provider<String>((ref) {
  return ref.watch(_timeLeftProvider);
});

final timeLeft = useProvider(timeLeftProvider);

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
    print('tamanio');
    print(data.categories.length);
//acceder a la categoria data.categories[0]['km']
    return _bodyCreate(data, context);
  }

  Widget _bodyCreate(EventModelUser data, BuildContext context) {
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
                width: size.width * 1,
                height: size.height * 0.74,
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
    var dataRun = {
      "kmTours": startDist(context, context.read(timeLeftProvider))[0],
      "timeTotal": context.read(timeLeftProvider),
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
          "km": startDist(context, context.read(timeLeftProvider))[0],
          "time": context.read(timeLeftProvider),
          "velocidad": startDist(context, context.read(timeLeftProvider))[1]
        }, context);
        context.read(timerProvider).reset();

        setState(() {
          _check = !_check;
        });
      }
    } else if (_check == false) {
      timeEnd = DateTime.now();
      final bool value = startResumen(context);
      if (!value) {
        context.read(timerProvider).startTimer();
        setState(() {
          _check = !_check;
        });
      }
    }
  }
}

class TimerTextWidget extends HookWidget {
  const TimerTextWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timeLeft = useProvider(timerProvider.state).timeLeft;
    return Text(
      timeLeft,
      style: Theme.of(context).textTheme.headline2,
    );
  }
}
