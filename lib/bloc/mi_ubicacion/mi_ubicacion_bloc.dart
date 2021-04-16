import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'mi_ubicacion_event.dart';
part 'mi_ubicacion_state.dart';

class MiUbicacionBloc extends Bloc<MiUbicacionEvent, MiUbicacionState> {
  MiUbicacionBloc() : super(MiUbicacionState());
  // ignore: cancel_subscriptions
  StreamSubscription<Position> _positionSucription;

  void iniciarSeguimiento() {
    //final geolcationOption = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
    this._positionSucription = Geolocator.getPositionStream(
            desiredAccuracy: LocationAccuracy.high, distanceFilter: 5)
        .listen((Position position) {
      final newLocation = new LatLng(position.latitude, position.longitude);
      add(OnUbicacionCambio(ubicacion: newLocation));
    });
  }

  void cancelarSeguimiento() {
    print('cancelar');
    this._positionSucription?.cancel();
  }

  @override
  Stream<MiUbicacionState> mapEventToState(
    MiUbicacionEvent event,
  ) async* {
    if (event is OnUbicacionCambio) {
      yield state.copyWith(existeUbicacion: true, ubicacion: event.ubicacion);
    }
  }
}
