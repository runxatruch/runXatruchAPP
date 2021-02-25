import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:runxatruch_app/bloc/mapa/mapa_bloc.dart';
import 'package:runxatruch_app/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';

class BTNmap extends StatefulWidget {
  const BTNmap({Key key}) : super(key: key);

  @override
  _BTNmapState createState() => _BTNmapState();
}

bool _check = false;

class _BTNmapState extends State<BTNmap> {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final mapaBloc = BlocProvider.of<MapaBloc>(context);
    // ignore: close_sinks
    final miUbicacion = BlocProvider.of<MiUbicacionBloc>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RaisedButton(
          child: Container(
              width: 95.0,
              height: 55,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [_check ? Text('Finalizar') : Text('Iniciar')])),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
          elevation: 5.0,
          color: Colors.lightBlue[800],
          textColor: Colors.white,
          onPressed: () => _playStop(mapaBloc),
        )
      ],
    );
  }

  _playStop(MapaBloc mapaBloc) {
    for (var item in mapaBloc.state.polylines.values) {
      print(item.points);
    }
    setState(() {
      _check = !_check;
    });
  }
}
