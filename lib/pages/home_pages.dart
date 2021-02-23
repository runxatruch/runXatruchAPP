import 'package:flutter/material.dart';
import 'package:runxatruch_app/pages/careers_page.dart';
import 'package:runxatruch_app/pages/porfile_page.dart';
import 'package:runxatruch_app/pages/preparation_page.dart';
import 'package:runxatruch_app/pages/toRun_page.dart';

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
    PreparationPages(),
    ToRunPage(),
    CareersPages(),
    PorfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: 
            Text('Comenzamos'),
            
            ),
        backgroundColor: Colors.teal[300],
      ),
      body: Container(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        //la linea  de abajo  lo que hace es mostrar los datos de los iconos
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
           BottomNavigationBarItem(
            icon: Icon(
              Icons.directions_run, 
              size: 30.0,
              color: Colors.orangeAccent,

            ),
            label: 'Entrenar',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.emoji_events_sharp,
              size: 30.0,
              color: Colors.tealAccent,
            ),
            label: 'Competir',
            
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.drag_handle_sharp,
              size: 30.0,
              color: Colors.redAccent,
            ),
            label: 'Carreras',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 30.0,
              color: Colors.black26,
            ),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.white60,
        backgroundColor: Colors.teal[300],
        //color del  iten cuando es seleccionado
        //color del iten cuando no esta seleccionadao
        //color de los iconos  por defecto esta en gris
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
