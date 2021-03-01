part of 'mapa_bloc.dart';

@immutable
class MapaState {
  final bool mapaListo;
  final bool dibujarRecorrido;
  final int theme;

  //Polylines
  final Map<String, Polyline> polylines;

  MapaState(
      {this.theme = 0,
      this.mapaListo = false,
      this.dibujarRecorrido = false,
      Map<String, Polyline> polylines})
      : this.polylines = polylines ?? new Map();

  MapaState copyWith(
          {bool mapaListo,
          bool dibujarRecorrido,
          int theme,
          Map<String, Polyline> polylines}) =>
      MapaState(
          mapaListo: mapaListo ?? this.mapaListo,
          theme: theme ?? this.theme,
          polylines: polylines ?? this.polylines,
          dibujarRecorrido: dibujarRecorrido ?? this.dibujarRecorrido);
}
