import 'dart:convert';

TrainingModel trainingModelFromJson(String str) =>
    TrainingModel.fromJson(json.decode(str));

String trainingModelToJson(TrainingModel data) => json.encode(data.toJson());

class TrainingModel {
  TrainingModel({
    this.iduser,
    this.km,
    this.speed,
    this.time,
    this.date,
    this.polylines,
  });

  String iduser;
  double km;
  double speed;
  String time;
  String date;
  List polylines;

  factory TrainingModel.fromJson(Map<String, dynamic> json) => TrainingModel(
        iduser: json["iduser"],
        km: json["km"].toDouble(),
        speed: json["speed"].toDouble(),
        time: json["time"],
        date: json["date"],
        polylines: json["polylines"],
      );

  Map<String, dynamic> toJson() => {
        "iduser": iduser,
        "km": km,
        "speed": speed,
        "time": time,
        "date": date,
        "polylines": polylines,
      };
}
