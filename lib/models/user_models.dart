// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String id;
  String nombres;
  String apellidos;
  String identidad;
  String email;
  String telefono;
  String fechaNac;
  String clave;
  String password;

  UserModel(
      {this.id,
      this.nombres,
      this.apellidos,
      this.identidad,
      this.email,
      this.telefono,
      this.fechaNac,
      this.clave,
      this.password});

  factory UserModel.fromJson(Map<String, dynamic> json) => new UserModel(
        id: json["id"],
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        identidad: json["identidad"],
        email: json["email"],
        telefono: json["telefono"],
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
        "fechaNac": fechaNac,
        "clave": clave,
        "pasword": password
      };
}
