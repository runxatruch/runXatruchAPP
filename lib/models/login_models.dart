// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

LoginModel cuentaModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String correo;
  String clave;

  LoginModel({
    this.correo,
    this.clave,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => new LoginModel(
        correo: json["correo"],
        clave: json["clave"],
      );

  Map<String, dynamic> toJson() => {"correo": correo, "clave": clave};
}
