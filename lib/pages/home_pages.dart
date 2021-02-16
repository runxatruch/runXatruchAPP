import 'package:flutter/material.dart';
import 'package:runxatruch_app/Widget/BottonNavigatorBar.dart';

class HomePages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
      ),
      body: Center(
        child: Text('Pagina Princial...'),
      ),

      //barra de navegacion
      bottomNavigationBar: BarraNavegacion(),
    );
  }
}
