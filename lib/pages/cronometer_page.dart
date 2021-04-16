import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:runxatruch_app/Widget/calculateDistance.dart';
import 'package:runxatruch_app/pages/timer.dart';

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

class cronometer extends StatefulWidget {
  cronometer({Key key}) : super(key: key);

  @override
  _cronometerState createState() => _cronometerState();
}

class _cronometerState extends State<cronometer> {
  @override
  Widget build(BuildContext context) {
    // return Container(
    //    child: child,
    // );
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

  reset(BuildContext context) {
    context.read(timerProvider).reset();
  }

  startTime(BuildContext context) {
    context.read(timerProvider).startTimer();
  }

  distance(BuildContext context) {
    return startDist(context, context.read(timeLeftProvider))[0];
  }

  time(BuildContext context) {
    return context.read(timeLeftProvider);
  }

  velocity(BuildContext context) {
    return startDist(context, context.read(timeLeftProvider))[1];
  }
}
