import 'dart:io';

import 'package:flutter/material.dart';

import 'package:runxatruch_app/utils/util.dart' as utils;
import 'package:runxatruch_app/prefUser/preferent_user.dart';
import 'package:runxatruch_app/utils/menu_alert.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:runxatruch_app/models/user_models.dart';
import 'package:runxatruch_app/provider/user_provider.dart';
import 'package:runxatruch_app/pages/example.dart';

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

  File foto, newImage;
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
                child: _createImg(data, context),
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
              Text("Fecha de nacimiento"),
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

  Widget _createImg(UserModel data, BuildContext context) {
    if (data.fotoUrl == "" || data.fotoUrl == null && foto == null) {
      return GestureDetector(
        onTap: () async {
          _navigateAndDisplaySelection(context);
          //Navigator.pushNamed(context, "example");
        },
        child: Image(
          image: AssetImage('assets/unnamed.png'),
          width: 160,
          height: 160,
        ),
      );
    } else {
      return GestureDetector(
        onTap: () async {
          _navigateAndDisplaySelection(context);
        },
        child: ClipRRect(
            borderRadius: BorderRadius.circular(80), child: _mostrarFoto(data)),
      );
    }
  }

  _mostrarFoto(UserModel data) {
    if (foto != null) {
      return Image.file(
        newImage,
        width: 140,
        height: 140,
        fit: BoxFit.fitHeight,
      );
    } else {
      return Image(
        width: 140,
        height: 140,
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
        _selectDate(context, data);
      },
    ));
  }

  //funcion enlazada a crear fecha de nacimiento
  _selectDate(BuildContext context, UserModel data) async {
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
        cambios = true;
        data.fechaNac = _fecha;
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
      validator: (value) {
        if (value == "") return null;
        if (utils.passwordValid(value)) {
          return null;
        } else {
          return 'Ingrese una contraseña valida';
        }
      },
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
    if (!_formKey.currentState.validate()) return;
    if (clave["nueva"] != "") {
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
      final data = {"msj": "Datos actualizados con exito", "route": true};
      mostrarAlerta(context, data);

      if (clave["nueva"] != "") {
        PreferenciasUsuario().credentialClear();
        Navigator.pushReplacementNamed(context, 'welcome');
      }
    } else {
      final data = {"msj": result["error"]};
      mostrarAlerta(context, data);
    }
    setState(() {
      _check = false;
    });
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // // Navigator.pop on the Selection Screen.
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    final File antImage = File('$tempPath/image2.png');
    try {
      await antImage.delete();
    } catch (e) {}
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Example()),
    );
    if (result == null) return;
    newImage = new File(result);

    foto = await newImage.copy('$tempPath/image2.png');
    setState(() {
      cambios = true;
    });
  }
}
