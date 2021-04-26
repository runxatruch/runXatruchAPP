import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:runxatruch_app/bloc/mapa/mapa_bloc.dart';
import 'package:runxatruch_app/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import '../pages/preparation_page.dart';
import '../pages/preparation_page.dart';
import '../pages/timer.dart';

import '../pages/preparation_page.dart';

final timerProvider = StateNotifierProvider<TimerNotifier>(
  (ref) => TimerNotifier(),
);

class BTNmap extends StatefulWidget {
  const BTNmap({Key key}) : super(key: key);

  @override
  _BTNmapState createState() => _BTNmapState();
}

//bool _check = false;

class _BTNmapState extends State<BTNmap> {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final mapaBloc = BlocProvider.of<MapaBloc>(context);
    // ignore: close_sinks
    final miUbicacion = BlocProvider.of<MiUbicacionBloc>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [],
    );
  }
}
