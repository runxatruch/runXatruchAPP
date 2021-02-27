import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:runxatruch_app/pages/careers_page.dart';
import 'package:runxatruch_app/pages/porfile_page.dart';
import 'package:runxatruch_app/pages/preparation_page.dart';
import 'package:runxatruch_app/pages/toRun_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//import 'package:google_maps_flutter/google_maps_flutter.dart'; para usar despues
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as lct;
import 'package:runxatruch_app/prefUser/preferent_user.dart';

/// This is the stateful widget that the main application instantiates.
class HomePage extends StatefulWidget {
  //BarraNavegacion({Key key}) : super(key: key);
  @override
  _BarraNavegacion createState() => _BarraNavegacion();
}

/// This is the private State class that goes with BarraNavegacion.
class _BarraNavegacion extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    const ProviderScope(child: PreparationPages()),
    ToRunPage(),
    CareersPages(),
    PorfilePage(),
  ];

  //variable que valida la ubicacion(es necesario jdk)
  lct.Location location;

  //sobre escribimos el metodo al inicio para que solicite los permisos al entrar
  @override
  void initState() {
    //getIcons();
    requestPerms();
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: (_widgetOptions.elementAt(_selectedIndex)),
      ),
      bottomNavigationBar: BottomNavigationBar(
        //la linea  de abajo  lo que hace es mostrar los datos de los iconos
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.directions_run,
              size: 30.0,
              //color: Colors.orangeAccent,
            ),
            label: 'Entrenar',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.emoji_events_sharp,
              size: 30.0,
              //color: Colors.tealAccent,
            ),
            label: 'Competir',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.drag_handle_sharp,
              size: 30.0,
              //color: Colors.redAccent,
            ),
            label: 'Carreras',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 30.0,
              //color: Colors.black26,
            ),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        //fixedColor: Colors.white60,         estilo que hector le dio
        //backgroundColor: Colors.teal[300],
        //color del  iten cuando es seleccionado
        //color del iten cuando no esta seleccionadao
        //color de los iconos  por defecto esta en gris
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  //solicitar permisos para que la aplicacion tenga acceso a la ubicacion(cuando se ingresa por primera vez)
  requestPerms() async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.locationAlways].request();
    var status = statuses[Permission.locationAlways];
    if (status == PermissionStatus.denied) {
      requestPerms();
    } else {
      gpsAnable();
    }
  }

  //activar gps(ubicacion) del telefono
  gpsAnable() async {
    location = lct.Location();
    bool statusResult = await location.requestService();
    if (!statusResult) {
      gpsAnable();
    } else {
      //flataria cargar el mapa para definir parametros y que se cierre la app o mande advertencia
    }
  }
}
