import 'package:flutter/material.dart';
import 'package:runxatruch_app/models/login_models.dart';
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
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Stack(
          children: [_crateForm(context)],
        ));
  }

  Widget _createBackground(BuildContext context) {}

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
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 20.0),
          child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Iniciar sesión'),
                Icon(Icons.arrow_forward_ios_sharp)
              ])),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 0.0,
      color: Colors.blue,
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

  _login(BuildContext context) {
    if (!keyLogin.currentState.validate()) return;
    keyLogin.currentState.save();

    //Pendiente de completacion
    print(login.clave);
    print(login.correo);

    Navigator.pushReplacementNamed(context, 'home');
  }
}
