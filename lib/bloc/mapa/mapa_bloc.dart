import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:runxatruch_app/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:runxatruch_app/theme/uber_map_theme.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  MapaBloc() : super(MapaState());

  GoogleMapController _controller;
  Polyline _miRuta = new Polyline(
      polylineId: PolylineId('mi_ruta'), width: 4, color: Colors.transparent);

  void initMapa(GoogleMapController controller) {
    if (!state.mapaListo) {
      this._controller = controller;
      //Cambiar estilo del mapa
      this._controller.setMapStyle(jsonEncode(uberMapTheme[0]));

      add(OnMapaListo());
    }
  }

  //Para mover la camara cuando se de ubicar en el mapa
  void moverCamera(LatLng destino) {
    final cameraUpdate = CameraUpdate.newLatLng(destino);
    this._controller?.animateCamera(cameraUpdate);
  }

  @override
  Stream<MapaState> mapEventToState(
    MapaEvent event,
  ) async* {
    if (event is OnMapaListo) {
      yield state.copyWith(mapaListo: true);
    } else if (event is OnNuevaUbicacion) {
      List<LatLng> points = [...this._miRuta.points, event.ubicacion];
      this._miRuta = this._miRuta.copyWith(pointsParam: points);
      final curretPolylines = state.polylines;
      curretPolylines['mi_ruta'] = this._miRuta;
      yield state.copyWith(polylines: curretPolylines, dibujarRecorrido: false);
    } else if (event is OnMarcarRecorrido) {
      // ignore: await_only_futures
      yield* await (this._onMarcarRecorrido(event));
      // TODO: implement mapEventToState
    } else if (event is OnNewTheme) {
      if (state.theme == 0) {
        this._controller.setMapStyle(jsonEncode(uberMapTheme[1]));
        yield state.copyWith(theme: 1);
        print('Leego ${state.theme}');
      } else if (state.theme == 1) {
        this._controller.setMapStyle(jsonEncode(uberMapTheme[0]));
        yield state.copyWith(theme: 0);
        print('Leego ${state.theme}');
      }

      yield state.copyWith(mapaListo: true);
    }
  }

  Stream<MapaState> _onMarcarRecorrido(OnMarcarRecorrido event) async* {
    if (!state.dibujarRecorrido) {
      this._miRuta = this._miRuta.copyWith(colorParam: Colors.blue);
    } else {
      List<LatLng> points = [];
      this._miRuta = this._miRuta.copyWith(pointsParam: points);
      this._miRuta = this._miRuta.copyWith(colorParam: Colors.transparent);
      MiUbicacionBloc().cancelarSeguimiento();
    }
    final currentPolylines = state.polylines;
    currentPolylines['mi_ruta'] = this._miRuta;

    yield state.copyWith(
        dibujarRecorrido: !state.dibujarRecorrido, polylines: currentPolylines);
  }
}
