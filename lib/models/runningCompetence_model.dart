import 'dart:convert';

RunningModel runningModelFromJson(String str) =>
    RunningModel.fromJson(json.decode(str));

String trainingModelToJson(RunningModel data) => json.encode(data.toJson());

class RunningModel {
  RunningModel(
      {this.idInscription,
      this.kmTours,
      this.route,
      this.state,
      this.timeEnd,
      this.timeStart,
      this.timeTotal});

  String idInscription;
  double kmTours;
  List route;
  String state;
  String timeEnd;
  String timeStart;
  String timeTotal;

  factory RunningModel.fromJson(Map<String, dynamic> json) => RunningModel(
        idInscription: json["idInscription"],
        kmTours: json["kmTours"].toDouble(),
        route: json["route"],
        state: json["state"],
        timeEnd: json["state"],
        timeStart: json["timeStart"],
        timeTotal: json["timeTotal"],
      );

  Map<String, dynamic> toJson() => {
        "idInscription": idInscription,
        "kmTours": kmTours,
        "route": route,
        "state": state,
        "timeEnd": timeEnd,
        "timeStart": timeStart,
        "timeTotal": timeTotal,
      };
}
