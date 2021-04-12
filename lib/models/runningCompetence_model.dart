import 'dart:convert';

RunningModel trainingModelFromJson(String str) =>
    RunningModel.fromJson(json.decode(str));

String trainingModelToJson(RunningModel data) => json.encode(data.toJson());

class RunningModel {
  RunningModel(
      {this.idCategory,
      this.idEvent,
      this.idUser,
      this.kmTours,
      this.route,
      this.state,
      this.timeEnd,
      this.timeStart,
      this.timeTotal});

  String idCategory;
  String idEvent;
  String idUser;
  double kmTours;
  List route;
  String state;
  String timeEnd;
  String timeStart;
  String timeTotal;

  factory RunningModel.fromJson(Map<String, dynamic> json) => RunningModel(
        idCategory: json["idCategory"],
        idEvent: json["idEvent"],
        idUser: json["idUser"],
        kmTours: json["kmTours"].toDouble(),
        route: json["route"],
        state: json["state"],
        timeEnd: json["state"],
        timeStart: json["timeStart"],
        timeTotal: json["timeTotal"],
      );

  Map<String, dynamic> toJson() => {
        "idCategory": idCategory,
        "idEvent": idEvent,
        "idUser": idUser,
        "kmTours": kmTours,
        "route": route,
        "state": state,
        "timeEnd": timeEnd,
        "timeStart": timeStart,
        "timeTotal": timeTotal,
      };
}
