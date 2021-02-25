import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:runxatruch_app/Widget/btnMap.dart';
import 'package:runxatruch_app/pages/map_page.dart';
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

class MyHomePage extends StatelessWidget {
  //const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 80),
              child: Column(
                children: <Widget>[
                  TimerTextWidget(),
                  SizedBox(
                    height: 40,
                  ),
                  Start(),

                  // ButtonsContainer(),

                  _createInformation()
                ],
              ),
            ),
            Divider(),
            GestureDetector(
              onTap: () => print('presiono'),
              child: Container(
                width: size.width * 1,
                height: size.height * 0.595,
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
                child: MapPage(),
              ),
            )
          ],
        ),
        floatingActionButton: BTNmap());
  }

  // Widget _cronometro() {
  //   return Center(
  //     child: Column(
  //       children: [
  //         Text(
  //           '00:00:00',
  //           style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
  //         ),
  //         SizedBox(
  //           height: 5,
  //         ),
  //         Text('Duracion')
  //       ],
  //     ),
  //   );
  // }

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
}

class TimerTextWidget extends HookWidget {
  const TimerTextWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timeLeft = useProvider(timerProvider.state).timeLeft;
    print('building TimerTextWidget $timeLeft');
    return Text(
      timeLeft,
      style: Theme.of(context).textTheme.headline2,
    );
  }
}

class Start extends StatefulWidget {
  const Start({Key key}) : super(key: key);

  @override
  _StartButton createState() => _StartButton();
}

class _StartButton extends State<Start> {
  // const StartButton({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
      color: Colors.lightBlue[800],
      textColor: Colors.white,
      onPressed: () => playStop(context),
    );
  }

  playStop(BuildContext context) {
    setState(() {
      _check = !_check;
    });

    if (_check == true) {
      print('Iniciar');
      context.read(timerProvider).startTimer();
    } else if (_check == false) {
      print('finalizar');
      context.read(timerProvider).pause();
    }
  }
}
