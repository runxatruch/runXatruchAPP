import 'package:flutter/material.dart';

class WelcomePages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _welcomeBody(context));
  }

  Widget _welcomeBody(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/fondo.png'), fit: BoxFit.cover),
           /*gradient: LinearGradient(
                colors: [Colors.cyan[700], Colors.lightBlue[800]],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter)*/
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 210,
              ),
              Text(
                'Bienvenido',
                style: TextStyle(
                    fontFamily: 'Camar', color: Colors.white, fontSize: 30),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'RunXatruch',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              SizedBox(
                height: 90,
              ),
              _createBottomLogin(context),
              SizedBox(
                height: 20.0,
              ),
              _createBottomRegister(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _createBottomLogin(BuildContext context) {
    return RaisedButton(
      child: Container(
          width: 200.0,
          padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
          child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Iniciar sesion'),
              ])),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 10.0,
      color: Colors.red[400],
      textColor: Colors.lightBlue[800],
      onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
    );
  }

  Widget _createBottomRegister(BuildContext context) {
    return RaisedButton(
      child: Container(
          width: 200.0,
          padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
          child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Registrarse'),
              ])),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0), 
        //side: BorderSide(color: Colors.red[400], width: 2.0),
      ),
      elevation: 10.0,
      color: Colors.white,
      textColor: Colors.red[400],
      onPressed: () => Navigator.pushReplacementNamed(context, 'createAccount'),

    );
  }
}
