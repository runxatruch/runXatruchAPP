import 'dart:convert';

EventModelUser eventModelFromJson(String str) =>
    EventModelUser.fromJson(json.decode(str));

String eventModelToJson(EventModelUser data) => json.encode(data.toJson());

class EventModelUser {
  EventModelUser({
    this.categories,
    this.city,
    this.descripEvent,
    this.endTime,
    this.idInscription,
    this.nameEvent,
    this.patrocinator,
    this.startTime,
  });

  List categories;
  String city;
  String descripEvent;
  String endTime;
  String idInscription;
  String nameEvent;
  List patrocinator;
  String startTime;

  factory EventModelUser.fromJson(Map<String, dynamic> json) => EventModelUser(
      categories: json["categories"],
      city: json["city"],
      descripEvent: json["descripEvent"],
      endTime: json["endTime"],
      idInscription: json["idInscription"],
      nameEvent: json["nameEvent"],
      patrocinator: json["patrocinator"],
      startTime: json["startTime"]);

  Map<String, dynamic> toJson() => {
        "categories": categories,
        "city": city,
        "descripEvent": descripEvent,
        "endTime": endTime,
        "idInscription": idInscription,
        "nameEvent": nameEvent,
        "patrocinator": patrocinator,
        "startTime": startTime,
      };
}
