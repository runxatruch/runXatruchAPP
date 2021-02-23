import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:runxatruch_app/models/login_models.dart';
import 'package:runxatruch_app/prefUser/preferent_user.dart';
import 'package:runxatruch_app/provider/auth_provider.dart';
import 'package:runxatruch_app/utils/menu_alert.dart';
import 'package:runxatruch_app/utils/util.dart' as utils;

class LoginPages extends StatefulWidget {
  @override
  _LoginPagesState createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  bool _checkbox = true;
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

  //Definicion de variables globales
  bool _showpasword = true;
  Widget _createBackground(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondoMorado = Container(
      height: size.height * 0.45,
      width: double.infinity,
      color: Colors.teal[300],
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
          padding: EdgeInsets.only(top: 20.0),
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
                      height: 5.0,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            focusColor: Colors.lightBlue[800],
                            activeColor: Colors.lightBlue[800],
                            value: _checkbox,
                            onChanged: (value) {
                              setState(() {
                                _checkbox = !_checkbox;
                              });
                            },
                          ),
                          Text('Mantener sesion inciada'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
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
          _createAccount(context),
          SizedBox(
            height: 40.0,
            width: double.infinity,
          ),
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
               fillColor: Colors.orange,
            icon: Icon(Icons.email, color: Colors.lightBlue[800]),
            suffixIcon: Icon(Icons.alternate_email,),
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
    print(_showpasword);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        obscureText: _showpasword,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
          labelText: 'Password',
          suffixIcon: GestureDetector(
            child: _showpasword ? Icon(Icons.lock) : Icon(Icons.lock_open),
            onTap: () => {
              setState(() {
                _showpasword = !_showpasword;
              })
            },
          ),
          icon: Icon(Icons.lock, color: Colors.lightBlue[800]),
        ),
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
      color: Colors.red[400],
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
        Navigator.pushReplacementNamed(context, 'createAccount');
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
    final result = await _auth.loginUser(login.correo, login.clave, _checkbox);
    if (result['ok']) {
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      mostrarAlerta(context, result['error']);
    }
  }
}
