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
  String password;
  List participations = [];

  UserModel(
      {this.id,
      this.nombres,
      this.apellidos,
      this.identidad,
      this.email,
      this.telefono,
      this.fechaNac,
      this.participations,
      this.password});

  factory UserModel.fromJson(Map<String, dynamic> json) => new UserModel(
        nombres: json["firstName"],
        apellidos: json["lastName"],
        identidad: json["identity"],
        email: json["email"],
        telefono: json["phone"],
        fechaNac: json["birthDate"],
        participations: json["participations"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": nombres,
        "lastName": apellidos,
        "identity": identidad,
        "email": email,
        "phone": telefono,
        "birthDate": fechaNac,
        "participations": participations == null ? [] : participations,
      };
}
