import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:runxatruch_app/theme/uber_map_theme.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  MapaBloc() : super(MapaState());

  GoogleMapController _controller;
  Polyline _miRuta = new Polyline(polylineId: PolylineId('mi_ruta'), width: 4);

  void initMapa(GoogleMapController controller) {
    if (!state.mapaListo) {
      this._controller = controller;
      //Cambiar estilo del mapa
      this._controller.setMapStyle(jsonEncode(uberMapTheme));

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
      yield state.copyWith(polylines: curretPolylines);
    }
    // TODO: implement mapEventToState
  }
}
