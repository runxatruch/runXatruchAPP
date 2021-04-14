import 'dart:convert';

EventModel eventModelFromJson(String str) =>
    EventModel.fromJson(json.decode(str));

String eventModelToJson(EventModel data) => json.encode(data.toJson());

class EventModel {
  EventModel({
    this.categories,
    this.city,
    this.descripEvent,
    this.endTime,
    this.id,
    this.inscriptionTime,
    this.nameEvent,
    this.patrocinator,
    this.startTime,
  });

  List categories;
  String city;
  String descripEvent;
  String endTime;
  String id;
  String inscriptionTime;
  String nameEvent;
  List patrocinator;
  String startTime;

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
      categories: json["categories"],
      city: json["city"],
      descripEvent: json["descripEvent"],
      endTime: json["endTime"],
      id: json["id"],
      inscriptionTime: json["inscriptionTime"],
      nameEvent: json["nameEvent"],
      patrocinator: json["patrocinator"],
      startTime: json["startTime"]);

  Map<String, dynamic> toJson() => {
        "categories": categories,
        "city": city,
        "descripEvent": descripEvent,
        "endTime": endTime,
        "id": id,
        "inscriptionTime": inscriptionTime,
        "nameEvent": nameEvent,
        "patrocinator": patrocinator,
        "startTime": startTime,
      };
}
