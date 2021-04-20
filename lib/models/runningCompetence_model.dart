import 'dart:convert';

RunningModel runningModelFromJson(String str) =>
    RunningModel.fromJson(json.decode(str));

String trainingModelToJson(RunningModel data) => json.encode(data.toJson());

class RunningModel {
  RunningModel(
      {this.idInscription,
      this.state,
      this.kmTotal,
      this.timeEnd,
      this.timeStart,
      this.timeTotal});

  String idInscription;
  String state;
  double kmTotal;
  String timeEnd;
  String timeStart;
  String timeTotal;

  factory RunningModel.fromJson(Map<String, dynamic> json) => RunningModel(
        idInscription: json["idInscription"],
        state: json["state"],
        kmTotal: json["kmTotal"],
        timeEnd: json["timeEnd"],
        timeStart: json["timeStart"],
        timeTotal: json["timeTotal"],
      );

  Map<String, dynamic> toJson() => {
        "idInscription": idInscription,
        "state": state,
        "kmTotal": kmTotal,
        "timeEnd": timeEnd,
        "timeStart": timeStart,
        "timeTotal": timeTotal,
      };
}
