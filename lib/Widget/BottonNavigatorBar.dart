import 'package:flutter/material.dart';


/// This is the stateful widget that the main application instantiates.
class BarraNavegacion extends StatefulWidget {
  //BarraNavegacion({Key key}) : super(key: key);

  @override
  _BarraNavegacion createState() => _BarraNavegacion();
}

/// This is the private State class that goes with BarraNavegacion.
class _BarraNavegacion extends State<BarraNavegacion> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Entrenar',
      style: optionStyle,
    ),
    Text(
      'Index 1: Competir',
      style: optionStyle,
    ),
    Text(
      'Index 2: Ranking',
      style: optionStyle,
    ),

    Text(
      'Index 3: Perfil',
      style: optionStyle,
    ),
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
        title: const Text('BottomNavigationBar ejemplo'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        //la linea  de abajo  lo que hace es mostrar los datos de los iconos 
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_sharp),
            label: 'Entrenar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            label: 'Competir',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wine_bar),
            label: 'Raking',
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.person_sharp),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        //color del  iten cuando es seleccionado
        selectedItemColor: Colors.amber[800],
        //color del iten cuando no esta seleccionadao 
        //color de los iconos  por defecto esta en gris 
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
