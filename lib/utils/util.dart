//import 'package:runxatruch_app/pages/account_pages.dart';

//verificando que sean tipo numerico

bool isNumeric(String s) {
  if (s.isEmpty) return false;

  final n = num.tryParse(s);

  return (n == null) ? false : true;
}

//verificando correo

RegExp regExp = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

bool validatorEmail(String c) {
  if (regExp.hasMatch(c)) {
    return true;
  } else {
    return false;
  }
}

//verificar cantidad de caracteres de identidad

bool identity(String id) {
  if (id.length > 13 || id.length < 13) {
    return false;
  } else {
    return true;
  }
}

//verificar telefono
bool numberTel(String tel) {
  if (tel.length < 12 || tel[0] != '+' || !isNumeric(tel.substring(0))) {
    return false;
  } else {
    return true;
  }
}

//validar clave
RegExp regExp2 = RegExp(r'^(?=\w*\d)(?=\w*[A-Z])(?=\w*[a-z])\S{8,16}$');

bool passwordValid(String pass) {
  if (!regExp2.hasMatch(pass)) {
    return false;
  } else {
    return true;
  }
}
