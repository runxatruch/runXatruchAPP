import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:runxatruch_app/models/trainingUser_model.dart';
import 'package:runxatruch_app/models/user_models.dart';
import 'package:runxatruch_app/prefUser/preferent_user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:runxatruch_app/utils/menu_alert.dart';

import 'auth_provider.dart';

class UserProvider {
  final _pref = PreferenciasUsuario();
  final firestoreInstance = FirebaseFirestore.instance;
  AuthProvider _auth = new AuthProvider();
  String urlImg;

  Future<List<UserModel>> getDataUser() async {
    final data = jsonDecode(_pref.credential);

    final mantener = data['mantener'];
    final List<UserModel> dataUser = new List();
    await firestoreInstance
        .collection("users")
        .where("email", isEqualTo: data['email'])
        .get()
        .then((value) {
      value.docs.forEach((result) {
        final user = UserModel.fromJson(result.data());
        print(user);
        final id = result.id;
        user.id = id;
        final data = {
          "email": user.email,
          "uid": user.id,
          "mantener": mantener
        };
        _pref.credential = jsonEncode(data);
        dataUser.add(user);
      });
    });
    print(dataUser);

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
        .then((value) => print('agregado con éxito'))
        .catchError((e) => print("error $e"));
  }

  Future<Map<String, dynamic>> updateUser(
      UserModel user, File img, Map password) async {
    Map<String, dynamic> resultfinal;
    if (password["nueva"] != "") {
      dynamic result = await _auth.updateuser(user.email, password);
      print(result);
      if (result['ok']) {
        dynamic resultupdate = await updateUsertemp(user, img);
        if (resultupdate["ok"]) {
          return {"ok": true};
        } else {
          return {"ok": false, "error": resultupdate["error"]};
        }
      } else {
        return {"ok": false, "error": result["error"]};
      }
    } else {
      dynamic resultupdate = await updateUsertemp(user, img);
      if (resultupdate["ok"]) {
        return {"ok": true};
      } else {
        return {"ok": false, "error": resultupdate["error"]};
      }
    }
  }

  Future<Map<String, dynamic>> updateUsertemp(UserModel user, File img) async {
    final data = jsonDecode(_pref.credential);
    if (img != null) {
      String name = data["uid"] + ".jpg";
      await uploadImg(img, name);
      user.fotoUrl = urlImg;
      return firestoreInstance
          .collection("users")
          .doc(data["uid"])
          .update(user.toJson())
          .then((value) {
        return {"ok": true};
      }).catchError((error) {
        return {"ok": false, "credential": error};
      });
    } else {
      return firestoreInstance
          .collection("users")
          .doc(data["uid"])
          .update(user.toJson())
          .then((value) {
        return {"ok": true};
      }).catchError((error) {
        return {"ok": false, "credential": error};
      });
    }
  }

  Future<List<TrainingModel>> getRouteUser() async {
    Query firestoreInstance =
        FirebaseFirestore.instance.collection("userTraining");
    final data = jsonDecode(_pref.credential);
    final List<TrainingModel> userRoute = new List();
    await firestoreInstance
        .where("iduser", isEqualTo: data['uid'])
        .orderBy("date", descending: true)
        .get()
        .then((value) {
      value.docs.forEach((result) {
        final value = TrainingModel.fromJson(result.data());
        userRoute.add(value);
      });
    });

    return userRoute;
  }

  uploadImg(File img, String name) async {
    print("*****${img.existsSync()}");

    final data = jsonDecode(_pref.credential);
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("PostImg");
    UploadTask uploadtask = ref.child(name).putFile(img);
    await downloadURLExample(name);
  }

  Future<void> downloadURLExample(String name) async {
    Reference ref = FirebaseStorage.instance.ref().child("PostImg").child(name);
    String url = (await ref.getDownloadURL()).toString();
    urlImg = url;
  }
}
