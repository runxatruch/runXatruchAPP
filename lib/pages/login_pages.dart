import 'package:flutter/material.dart';

class LoginPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Stack(
          children: [_crateForm(context)],
        ));
  }

  //Funcion para crear el fondo de la pantalla de login
  Widget _createBackground(BuildContext context) {}

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
                Text('Ingrese su informacion para iniciar seccion'),
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
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 20.0),
          child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Iniciar sesion'),
                Icon(Icons.arrow_forward_ios_sharp)
              ])),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 0.0,
      color: Colors.blue,
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
