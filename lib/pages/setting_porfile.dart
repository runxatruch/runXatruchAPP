import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:runxatruch_app/prefUser/preferent_user.dart';
import 'package:runxatruch_app/utils/menu_alert.dart';
import 'package:runxatruch_app/utils/util.dart' as utils;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:runxatruch_app/models/user_models.dart';
import 'package:runxatruch_app/provider/user_provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  UserProvider userProvider = new UserProvider();
  bool _showpasword = true, _showpasword2 = true, cambios = false;
  String _fecha = '';
  Map clave = {"actual": "", "nueva": ""};
  bool _check = false;
  TextEditingController _inputFieldDateController = new TextEditingController();

  File foto;
  UserModel user = new UserModel();
  double size;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size.width;
    Future<List<UserModel>> args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Editar perfil"),
      ),
      body: Stack(children: [
        FutureBuilder(
          future: args,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return _createBody(snapshot.data[0]);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        )
      ]),
    );
  }

  Widget _createBody(UserModel data) {
    print(data.id);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Center(
                child: _createImg(data),
              ),
              Text("Nombre"),
              Container(
                  child: TextFormField(
                onChanged: (value) {
                  data.nombres = value;
                  cambios = true;
                },
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: '${data.nombres}',
                ),
              )),
              SizedBox(
                height: 10,
              ),
              Text("Apellido"),
              Container(
                  child: TextFormField(
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  data.apellidos = value;
                  cambios = true;
                },
                decoration: InputDecoration(
                  hintText: '${data.apellidos}',
                ),
              )),
              SizedBox(
                height: 10,
              ),
              Text("Identidad"),
              Container(
                  child: TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  data.identidad = value;
                  cambios = true;
                },
                decoration: InputDecoration(
                  hintText: '${data.identidad}',
                ),
              )),
              SizedBox(
                height: 10,
              ),
              Text("Fecha de naciento"),
              _createBirthDate(context, data),
              SizedBox(
                height: 20,
              ),
              Text(
                "Cambiar contraseña",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 30,
              ),
              Text("Contraseña actual"),
              _createPass(),
              SizedBox(
                height: 10,
              ),
              Text("Nueva  contraseña"),
              _createnewPass(),
              SizedBox(
                height: 30,
              ),
              _createBtn(data, context),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createImg(UserModel data) {
    return GestureDetector(
      onTap: () async {
        await _procesarImge();
        setState(() {});
      },
      child: ClipRRect(
          borderRadius: BorderRadius.circular(60), child: _mostrarFoto(data)),
    );
  }

  _mostrarFoto(UserModel data) {
    if (data.fotoUrl == "" || foto != null || data.fotoUrl == null) {
      return Image.file(
        foto,
        width: 120,
        height: 140,
        fit: BoxFit.fitHeight,
      );
    } else {
      return Image(
        width: 100,
        height: 130,
        fit: BoxFit.fitHeight,
        image: NetworkImage(
          data.fotoUrl,
        ),
      );
    }
  }

  _procesarImge() async {
    final _picker = ImagePicker();
    final pickerImagen = await _picker.getImage(source: ImageSource.gallery);
    if (pickerImagen != null) {
      foto = File(pickerImagen.path);
      cambios = true;

      if (foto != null) {
        user.fotoUrl = "";
      }
    }
  }

  Widget _createBirthDate(BuildContext context, UserModel data) {
    return Container(
        child: TextFormField(
      enableInteractiveSelection: false,
      controller: _inputFieldDateController,
      onChanged: (value) {
        cambios = true;
        data.fechaNac = value;
      },
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        hintText: data.fechaNac,
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
    ));
  }

  //funcion enlazada a crear fecha de nacimiento
  _selectDate(BuildContext context) async {
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    DateTime picker = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(1960, 01, 01),
        lastDate: new DateTime.now(),
        locale: Locale('es', 'ES'));

    if (picker != null) {
      setState(() {
        _fecha = formatter.format(picker).toString(); //picker.toString();
        _inputFieldDateController.text = _fecha;
      });
    }
  }

  Widget _createPass() {
    return TextFormField(
        obscureText: _showpasword,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            suffixIcon: GestureDetector(
          child: _showpasword ? Icon(Icons.lock) : Icon(Icons.lock_open),
          onTap: () => {
            setState(() {
              _showpasword = !_showpasword;
            })
          },
        )),
        onChanged: (value) {
          cambios = true;
          clave["actual"] = value;
        });
  }

  Widget _createnewPass() {
    return TextFormField(
      obscureText: _showpasword,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          suffixIcon: GestureDetector(
        child: _showpasword2 ? Icon(Icons.lock) : Icon(Icons.lock_open),
        onTap: () => {
          setState(() {
            _showpasword2 = !_showpasword2;
          })
        },
      )),
      onChanged: (value) {
        clave["nueva"] = value;
        cambios = true;
      },
    );
  }

  Widget _createBtn(UserModel data, BuildContext context) {
    if (_check) {
      return Center(child: CircularProgressIndicator());
    } else {
      return OutlineButton(
        borderSide: BorderSide(color: Colors.red[400]),
        disabledBorderColor: Colors.white,
        child: Container(
            width: size * 0.9,
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('Actualizar datos  ')])),
        color: Colors.white,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        textColor: Colors.red[400],
        onPressed: () => _login(data, context),
      );
    }
  }

  _login(UserModel data, BuildContext context) async {
    print(clave);
    if (clave["nueva"] != "") {
      print("here");
      if (clave["nueva"] == clave["actual"]) {
        mostrarAlerta(
            context, {"msj": "Las contraseñas no tienen que coincidir"});
        return;
      }
    }
    if (!cambios) {
      mostrarAlerta(context, {"msj": "No se han realizado cambios"});
      return;
    }
    setState(() {
      _check = true;
    });

    final result = await userProvider.updateUser(data, foto, clave);
    if (result["ok"]) {
      final data = {"msj": "Datos actualizados con exito"};
      mostrarAlerta(context, data);
      if (clave["nueva"] != "") {
        PreferenciasUsuario().credentialClear();
        Navigator.pushReplacementNamed(context, 'welcome');
      }
    } else {
      print(result);
      final data = {"msj": result["error"]};
      mostrarAlerta(context, data);
    }
    setState(() {
      _check = false;
    });
  }
}
