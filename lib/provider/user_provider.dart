import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:runxatruch_app/models/trainingUser_model.dart';
import 'package:runxatruch_app/models/user_models.dart';
import 'package:runxatruch_app/prefUser/preferent_user.dart';

class UserProvider {
  final _pref = PreferenciasUsuario();
  final firestoreInstance = FirebaseFirestore.instance;

  Future<List<UserModel>> getDataUser() async {
    final data = jsonDecode(_pref.credential);

    final List<UserModel> dataUser = new List();
    await firestoreInstance
        .collection("users")
        .where("email", isEqualTo: data['email'])
        .get()
        .then((value) {
      value.docs.forEach((result) {
        final user = UserModel.fromJson(result.data());
        final id = result.id;
        user.id = id;
        final data = {"email": user.email, "uid": user.id};
        _pref.credential = jsonEncode(data);
        dataUser.add(user);
      });
    });

    return dataUser;
  }

  saveRouteUser(TrainingModel data) async {
    final user = jsonDecode(_pref.credential);
    data.iduser = user['uid'];
    DateTime now = new DateTime.now();
    data.date = new DateTime(now.year, now.month, now.day, now.hour, now.minute)
        .toString();
    print(data.date);
    return await firestoreInstance
        .collection("userTraining")
        .add(data.toJson())
        .then((value) => print('agregado cone xito'))
        .catchError((e) => print("error $e"));
  }

  Future<List<TrainingModel>> getRouteUser() async {
    final data = jsonDecode(_pref.credential);
    final List<TrainingModel> userRoute = new List();
    await firestoreInstance
        .collection("userTraining")
        .where("iduser", isEqualTo: data['uid'])
        .get()
        .then((value) {
      value.docs.forEach((result) {
        final value = TrainingModel.fromJson(result.data());
        userRoute.add(value);
      });
    });

    return userRoute;
  }
}
