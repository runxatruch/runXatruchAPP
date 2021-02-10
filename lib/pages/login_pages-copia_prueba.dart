import 'package:flutter/material.dart';

class LoginPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Center(
          child: Text('Pagina de iniciar sesion'),
        ),
        floatingActionButton: _crearBotones());
  }
}

Widget _crearBotones() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
      SizedBox(width: 30),
      Expanded(child: SizedBox()),
      FloatingActionButton(
          child: Icon(Icons.accessible_forward), onPressed: null),
      SizedBox(
        width: 5.0,
      ),
    ],
  );
}
