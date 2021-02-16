import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:runxatruch_app/models/login_models.dart';
import 'package:runxatruch_app/provider/auth_provider.dart';
import 'package:runxatruch_app/utils/util.dart' as utils;

class LoginPages extends StatefulWidget {
  @override
  _LoginPagesState createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  LoginModel login = new LoginModel();
  final keyLogin = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final LoginModel userData = ModalRoute.of(context).settings.arguments;
    if (userData != null) {
      login = userData;
    }

    return Scaffold(
        body: Stack(
      children: [_createBackground(context), _crateForm(context)],
    ));
  }

  Widget _createBackground(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondoMorado = Container(
      height: size.height * 0.45,
      width: double.infinity,
      color: Colors.lightBlue[800],
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );
    return Stack(
      children: [
        fondoMorado,
        Positioned(
          child: circulo,
          top: 110.0,
          left: 30.0,
        ),
        Positioned(
          child: circulo,
          top: -40.0,
          right: -30.0,
        ),
        Positioned(
          child: circulo,
          bottom: 100.0,
          right: 80.0,
        ),
        Positioned(
          child: circulo,
          bottom: -50.0,
          right: 20.0,
        ),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: [
              SizedBox(
                height: 10.0,
                width: double.infinity,
              ),
              Image(
                image: AssetImage('assets/logo.png'),
                height: 200.0,
                fit: BoxFit.cover,
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _crateForm(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
            child: Container(
              height: 200.0,
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
              child: Form(
                key: keyLogin,
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
              )),
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

  Widget _createEmail() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            icon: Icon(Icons.email),
            suffixIcon: Icon(Icons.alternate_email),
            hintText: 'example@example.com',
            labelText: 'Correo Electornico',
          ),
          onSaved: (value) => login.correo = value,
          validator: (value) {
            if (utils.validatorEmail(value)) {
              return null;
            } else {
              return 'Ingrese un correo válido';
            }
          },
        ));
  }

  Widget _createPass() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        obscureText: true,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            labelText: 'Password',
            suffixIcon: Icon(Icons.lock_open),
            icon: Icon(Icons.lock)),
        onSaved: (value) => login.clave = value,
        validator: (value) {
          if (utils.passwordValid(value)) {
            return null;
          } else {
            return 'Mayúscula/s, minúsculas/s, número/s';
          }
        },
      ),
    );
  }

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

  _login(BuildContext context) async {
    AuthProvider _auth = new AuthProvider();
    if (!keyLogin.currentState.validate()) return;
    keyLogin.currentState.save();
    final result = await _auth.loginUser(login.correo, login.clave);
    if (result['ok']) {
      UserCredential userCredential = result['credential'];
      userCredential.user;
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      //Error
      print(result['error']);
    }
  }
}
