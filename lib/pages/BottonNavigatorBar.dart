import 'package:flutter/material.dart';

import 'navigation_structure/widgetSettings.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //1.BottomNav. indice del selector del bottomNavigation.
  int _selectedIndex = 0;
  //2.BottomNav lista de opciones del bottomNavigation.
  static List<Widget> _widgetOptions = <Widget>[
    Text('Index 0: entrenar'),
    Text('Index 1: competicion'),
    Text('Index 2: Ranking'),
    WidgetSettings()
  ];
  //3.BottomNav función que indica que guarda el valor del índice seleccionado
  void _selectedOptionInMyBottomNavigation(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //5. BottomNav elemento que se muestra actualmente en esta pantalla/widget/pantalla principal.
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      //1. Drawer, Implementación de drawer. Se define un menu lateral con cabecera y lista de items.
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text(
                  'Drawer cabecera',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                )),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Perfil'),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Mensajes'),
            )
          ],
        ),
      ),

      //4.BottomNav Implementación de la navegación en el bottomNavigation.
      bottomNavigationBar: BottomNavigationBar(
        //la line de abajo  lo que hace es mostrar los datos de los iconos 
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home_sharp), title:  Text('Entrenar')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.flag), title: Text('Competicion')
          ),

          
          BottomNavigationBarItem(
              icon: Icon(Icons.wine_bar), title: Text('Ranking')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_sharp), title: Text('Perfil')
          )
        ],
        currentIndex: _selectedIndex,
        //color de los iconos 
        unselectedItemColor: Colors.grey,
        //color seleccionado
        selectedItemColor: Colors.blue,
        onTap: _selectedOptionInMyBottomNavigation,
      ),
    );
  }
}
