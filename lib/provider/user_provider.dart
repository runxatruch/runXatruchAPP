import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:runxatruch_app/models/user_models.dart';
import 'package:runxatruch_app/prefUser/preferent_user.dart';

class UserProvider {
  final _pref = PreferenciasUsuario();

  Future<List<UserModel>> getDataUser() async {
    final data = jsonDecode(_pref.credential);
    final firestoreInstance = FirebaseFirestore.instance;
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
}
