import 'dart:convert';

RuteModel ruteModelFromJson(String str) => RuteModel.fromJson(json.decode(str));

String ruteModelToJson(RuteModel data) => json.encode(data.toJson());

class RuteModel {
  RuteModel({
    this.id,
    this.rute,
  });

  String id;
  List<dynamic> rute;

  factory RuteModel.fromJson(Map<String, dynamic> json) => RuteModel(
        id: json["id"],
        rute: List<dynamic>.from(json["rute"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rute": List<dynamic>.from(rute.map((x) => x)),
      };
}
