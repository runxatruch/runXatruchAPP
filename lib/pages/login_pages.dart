import 'package:flutter/material.dart';
import 'dart:math';

class LoginPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Login')),
          elevation: 0.0,
        ),
        body: Stack(
          children: [_crateForm(context)],
        ));
  }

  //Funcion para crear el fondo de la pantalla de login
  Widget _createBackground(BuildContext context) {
    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset(0.0, 0.5),
              end: FractionalOffset(0.0, 1.0),
              colors: [
            Color.fromRGBO(52, 37, 101, 1.0),
            Color.fromRGBO(35, 37, 57, 1.0)
          ])),
    );

    final cajaRosa = Transform.rotate(
        angle: -pi / 3.0,
        child: Container(
          height: 360.0,
          width: 300.0,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.lightBlue[800], Colors.lightBlue[800]]),
              borderRadius:
                  BorderRadius.horizontal(left: Radius.circular(100.0)),
              color: Colors.pink),
        ));

    return Stack(children: [Positioned(child: cajaRosa, top: -150)]);
  }

  // Funcion que retorna el formulario para el apartado de inicio de seccion
  Widget _crateForm(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
            child: Container(
              height: 100.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            padding: EdgeInsets.symmetric(vertical: 50.0),
            margin: EdgeInsets.symmetric(vertical: 20.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0))
                ]),
            child: Column(
              children: [
                Text('Ingrese su información para iniciar sesión'),
                SizedBox(
                  height: 40.0,
                ),
                _createEmail(),
                SizedBox(
                  height: 20.0,
                ),
                _createPass(),
                SizedBox(
                  height: 30.0,
                ),
                _createBottom(context),
              ],
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          _recuperar(context),
          SizedBox(
            height: 15.0,
          ),
          _createAccount(context)
        ],
      ),
    );
  }

  //Crear el input para ingresar el correo electronico
  Widget _createEmail() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            icon: Icon(Icons.email),
            suffixIcon: Icon(Icons.alternate_email),
            hintText: 'example@example.com',
            labelText: 'Correo Electornico',
          ),
        ));
  }

  Widget _createPass() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        obscureText: true,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            labelText: 'Password',
            suffixIcon: Icon(Icons.lock_open),
            icon: Icon(Icons.lock)),
      ),
    );
  }

  //Funcion que retorna el widget que almacena el boton de iniciar seccion
  Widget _createBottom(BuildContext context) {
    return RaisedButton(
      child: Container(
          width: 220.0,
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Iniciar sesión'),
                Icon(Icons.arrow_forward_ios_sharp)
              ])),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 5.0,
      color: Colors.lightBlue[800],
      textColor: Colors.white,
      onPressed: () => _login(context),
    );
  }

  //Funcion que retorna el widget del apartado de recuperar contraseña
  Widget _recuperar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'recoverAccount');
      },
      child: Container(
        child: Text(
          '¿Olvidaste tu contraseña?',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  //Funcion que retorna el widget del apartado de Registrarse
  Widget _createAccount(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'createAccount');
      },
      child: Container(
        child: Text(
          '¿No tienes cuenta? Registrate',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  //Funcion que se ejecuta al presionar el boton "Iniciar sesion"
  _login(BuildContext context) {
    //Pendiente de completacion

    Navigator.pushReplacementNamed(context, 'home');
  }
}
