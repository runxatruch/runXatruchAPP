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
    this.finalized,
    this.inscriptionTime,
    this.nameEvent,
    this.patrocinator,
    this.startTime,
  });

  List<dynamic> categories;
  String city;
  String descripEvent;
  String endTime;
  String id;
  String finalized;
  String inscriptionTime;
  String nameEvent;
  List<dynamic> patrocinator;
  String startTime;

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        categories: List<dynamic>.from(json["categories"].map((x) => x)),
        city: json["city"],
        descripEvent: json["descripEvent"],
        endTime: json["endTime"],
        id: json["id"],
        finalized: json["finalized"],
        inscriptionTime: json["inscriptionTime"],
        nameEvent: json["nameEvent"],
        patrocinator: List<dynamic>.from(json["patrocinator"].map((x) => x)),
        startTime: json["startTime"],
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "city": city,
        "descripEvent": descripEvent,
        "endTime": endTime,
        "id": id,
        "finalized": finalized,
        "inscriptionTime": inscriptionTime,
        "nameEvent": nameEvent,
        "patrocinator": List<dynamic>.from(patrocinator.map((x) => x)),
        "startTime": startTime,
      };
}
