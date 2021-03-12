import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:runxatruch_app/Widget/calculateDistance.dart';
import 'package:runxatruch_app/pages/historial_training.dart';
import 'package:runxatruch_app/pages/map_page.dart';
import 'package:runxatruch_app/utils/util.dart';
import 'timer.dart';

bool _check = false;

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

class PreparationPages extends StatelessWidget {
  const PreparationPages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
        routes: {'historial': (BuildContext context) => HistorialTraining()},
        theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.light,
          primaryColor: Colors.red[400], //red[400],
          accentColor: Colors.red[400], //red[400],

          // Define the default TextTheme. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
        ));
  }
}

class MyHomePage extends StatefulWidget {
  //const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 40),
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
              Divider(),
              Container(
                  width: size.width * 1,
                  height: size.height * 0.75,
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
        )
      ]),
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
            CircleAvatar(
              backgroundColor: Colors.white,
              maxRadius: 25,
              child: IconButton(
                icon: Icon(Icons.subject, color: Colors.red[400]),
                onPressed: () {
                  Navigator.pushNamed(context, 'historial');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createInformation() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_createDistan(), _createRitmo()],
      ),
    );
  }

  Widget _createDistan() {
    return Column(
      children: [
        Text(
          '0,00',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Text('Distancia (km)')
      ],
    );
  }

  Widget _createRitmo() {
    return Column(
      children: [
        Text(
          '0,00',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'Distancia (km)',
        )
      ],
    );
  }

  Widget _btnStart(BuildContext context) {
    return RaisedButton(
      child: Container(
          width: 95.0,
          height: 55,
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
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

  playStop(BuildContext context) {
    if (_check == true) {
      final bool value = stopResumen(true, context);
      if (value) {
        showAbstract({
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
