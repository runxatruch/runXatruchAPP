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
    this.nameEvent,
    this.patrocinator,
    this.startTime,
  });

  List categories;
  String city;
  String descripEvent;
  String endTime;
  String nameEvent;
  List patrocinator;
  String startTime;

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
      categories: json["categories"],
      city: json["city"],
      descripEvent: json["descripEvent"],
      endTime: json["endTime"],
      nameEvent: json["nameEvent"],
      patrocinator: json["patrocinator"],
      startTime: json["startTime"]);

  Map<String, dynamic> toJson() => {
        "categories": categories,
        "city": city,
        "descripEvent": descripEvent,
        "endTime": endTime,
        "nameEvent": nameEvent,
        "patrocinator": patrocinator,
        "startTime": startTime,
      };
}
