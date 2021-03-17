import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:runxatruch_app/bloc/mapa/mapa_bloc.dart';

startDist(BuildContext context, String timer) {
  //.....Debo acceder a los segundos y minutos
  // ignore: close_sinks
  final mapaBloc = BlocProvider.of<MapaBloc>(context);
  final list = List();
  for (var item in mapaBloc.state.polylines.values) {
    print('--------');
    //int position = 0;
    print(item.points);
    //print(position);
    final double latInitial = item.points[0].latitude;
    final double lonInitial = item.points[0].longitude;
    final double latFinal = item.points[item.points.length - 1].latitude;
    final double lonFinal = item.points[item.points.length - 1].longitude;
    //var timeLeftProvider;
    //final seconds = context.read(timeLeftProvider);

    // print(latInitial);
    // print(latFinal);
    double distanceKM = distance(latInitial, lonInitial, latFinal, lonFinal);

    //final timeLeft = useProvider(timerProvider.state).timeLeft;
    print('distancia en km es $distanceKM');
    String distancia = distanceKM.toStringAsPrecision(2);
    list.add(double.parse(distancia));
    //distancia = 0;
    //print('distancia KM: $distanceKM');
    final arrayTimer = timer.split(':');
    final minutes = arrayTimer[0];
    final seconds = arrayTimer[1];
    final timerFinal =
        double.parse(minutes) / 60 + double.parse(seconds) / 3600;

    //print(timerFinal);
    double average = calculateProm(timerFinal, distanceKM);
    String promedio = average.toStringAsPrecision(2);

    list.add(double.parse(promedio));

    return list;
  }
}

//return Text('hola');
double distance(
    double latInitial, double lonInitial, double latFinal, double lonFinal) {
  final double distance =
      Geolocator.distanceBetween(latInitial, lonInitial, latFinal, lonFinal);
  final double distanceKM = distance / 1000;
  //print('km recorridos: $distanceKM');
  return distanceKM;
}

double calculateProm(double hours, double km) {
  return km / hours;
}
