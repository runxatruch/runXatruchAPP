// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

CuentaModel cuentaModelFromJson(String str) =>
    CuentaModel.fromJson(json.decode(str));

String cuentaModelToJson(CuentaModel data) => json.encode(data.toJson());

class CuentaModel {
  String id;
  String nombres;
  String apellidos;
  String identidad;
  String email;
  String telefono;
  String ciudad;
  String fechaNac;
  String clave;
  String password;

  CuentaModel(
      {this.id,
      this.nombres,
      this.apellidos,
      this.identidad,
      this.email,
      this.telefono,
      this.ciudad,
      this.fechaNac,
      this.clave,
      this.password});

  factory CuentaModel.fromJson(Map<String, dynamic> json) => new CuentaModel(
        id: json["id"],
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        identidad: json["identidad"],
        email: json["email"],
        telefono: json["telefono"],
        ciudad: json["ciudad"],
        fechaNac: json["fechaNac"],
        clave: json["clave"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombres": nombres,
        "apellidos": apellidos,
        "identidad": identidad,
        "email": email,
        "telefono": telefono,
        "ciudad": ciudad,
        "fechaNac": fechaNac,
        "clave": clave,
        "pasword": password
      };
}
