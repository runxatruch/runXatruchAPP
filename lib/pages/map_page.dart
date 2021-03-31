import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:runxatruch_app/bloc/mapa/mapa_bloc.dart';
import 'package:runxatruch_app/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

bool type = false;
final Set<Marker> _markers = {};
final Set<Polyline> _polyline = {};

class MapPage extends StatefulWidget {
  const MapPage({
    Key key,
    this.route,
  }) : super(key: key);

  final List<LatLng> route;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    BlocProvider.of<MiUbicacionBloc>(context).iniciarSeguimiento();
    super.initState();
  }

  @override
  void dispose() {
    BlocProvider.of<MiUbicacionBloc>(context).cancelarSeguimiento();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    type = false;
    if (widget.route != null) {
      _polyline.clear();
      _markers.clear();
      type = true;
      LatLng _lastMapPosition = widget.route[0];
      _polyline.add(Polyline(
        polylineId: PolylineId(_lastMapPosition.toString()),
        visible: true,
        //latlng is List<LatLng>
        points: widget.route,
        color: Colors.blue,
      ));
      _markers.add(Marker(
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(title: 'Inicio de la carrera'),
        icon: BitmapDescriptor.defaultMarkerWithHue(30.0),
      ));
      _markers.add(Marker(
        markerId: MarkerId(widget.route.last.toString()),
        position: widget.route.last,
        infoWindow: InfoWindow(
          title: 'Linea de meta',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    }
    return Scaffold(
      body: BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
          builder: (context, state) => crearMap(state)),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [],
      ),
    );
  }

  Widget crearMap(MiUbicacionState state) {
    if (!state.existeUbicacion)
      return Center(
        child: Image(
          image: AssetImage('assets/location.gif'),
        ),
      );
    // ignore: close_sinks
    final mapaBloc = BlocProvider.of<MapaBloc>(context);
    CameraPosition cameraPosition;
    if (type) {
      print('here');
      mapaBloc.add(OnNuevaUbicacion(ubicacion: widget.route[0]));
      cameraPosition = new CameraPosition(target: widget.route[0], zoom: 15.0);
    } else {
      mapaBloc.add(OnNuevaUbicacion(ubicacion: state.ubicacion));
      cameraPosition = new CameraPosition(target: state.ubicacion, zoom: 15.0);
    }

    return Container(
      child: GoogleMap(
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
          new Factory<OneSequenceGestureRecognizer>(
            () => new EagerGestureRecognizer(),
          ),
        ].toSet(),
        markers: type ? _markers : null,
        initialCameraPosition: cameraPosition,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        polylines: type ? _polyline : mapaBloc.state.polylines.values.toSet(),
      ),
    );
  }
}
