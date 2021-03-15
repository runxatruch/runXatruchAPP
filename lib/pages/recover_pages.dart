import 'package:flutter/material.dart';
import 'package:runxatruch_app/provider/auth_provider.dart';
import 'package:runxatruch_app/utils/menu_alert.dart';

import 'package:runxatruch_app/utils/util.dart' as utils;

class RecoverAccount extends StatefulWidget {
  @override
  _RecoverAccountState createState() => _RecoverAccountState();
}

class _RecoverAccountState extends State<RecoverAccount> {
  String email;
  double size;
  bool _check = false, _check2 = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Recuperar contraseña'),
      ),
      body: _createBody(),
    );
  }

  Widget _createBody() {
    if (_check2) {
      return Container(
        margin: EdgeInsets.only(top: 30),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                Text('Se envio un mensaje al correo '),
                Text(
                  "$email",
                  style: TextStyle(color: Colors.red[400]),
                ),
              ],
            ),
            Divider(
              height: 30,
            ),
            Text("¿No recibio el mensaje?"),
            GestureDetector(
              onTap: () {
                setState(() {
                  _check2 = false;
                });
              },
              child: Container(
                child: Text(
                  'Precione aqui para volver a intentar',
                  style: TextStyle(color: Colors.red[400]),
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                  'Se enviara un mensaje a su correo electronico para solicitar la recuperacion de la contraseña...'),
            ),
            Divider(),
            _createEmail(),
            SizedBox(
              height: 20,
            ),
            _createBtn(size)
          ],
        ),
      );
    }
  }

  Widget _createEmail() {
    return Form(
      key: _formKey,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
              fillColor: Colors.orange,
              icon: Icon(
                Icons.email, /*color: Colors.lightBlue[800]*/
              ),
              suffixIcon: Icon(
                Icons.alternate_email,
              ),
              hintText: 'example@example.com',
              labelText: 'Correo Electornico',
            ),
            onChanged: (value) {
              email = value;
            },
            validator: (value) {
              if (utils.validatorEmail(value)) {
                return null;
              } else {
                return 'Ingrese un correo válido';
              }
            },
          )),
    );
  }

  Widget _createBtn(double size) {
    if (_check) {
      return Center(child: CircularProgressIndicator());
    } else {
      return OutlineButton(
        borderSide: BorderSide(color: Colors.red[400]),
        disabledBorderColor: Colors.white,
        child: Container(
            width: size * 0.8,
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('Enviar  ')])),
        color: Colors.white,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        textColor: Colors.red[400],
        onPressed: () => _send(),
      );
    }
  }

  _send() {
    print("***** $email");
    if (!_formKey.currentState.validate()) return;
    setState(() {
      _check = true;
    });
    final resp = AuthProvider().resetPassword(email);
    resp.then((e) {
      if (!e["ok"]) {
        mostrarAlerta(
            context, {"msj": "No se tienen registros del correo $email"});
        setState(() {
          _check = false;
        });
      } else {
        setState(() {
          _check = false;
          _check2 = true;
        });
      }
    });
  }
}
