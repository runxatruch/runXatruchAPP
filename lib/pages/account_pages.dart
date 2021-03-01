import 'dart:math';
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:runxatruch_app/models/user_models.dart';
import 'package:runxatruch_app/prefUser/preferent_user.dart';
import 'package:runxatruch_app/provider/auth_provider.dart';
import 'package:runxatruch_app/utils/menu_alert.dart';
import 'package:runxatruch_app/utils/util.dart' as utils;

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  UserModel userAccount = new UserModel();
  AuthProvider _auth = new AuthProvider();

  final formkey = GlobalKey<FormState>();
  TextEditingController pass1 = new TextEditingController();
  TextEditingController pass2 = new TextEditingController();

  final keyClave = GlobalKey<FormFieldState>();
  String _fecha = '';

  TextEditingController _inputFieldDateController = new TextEditingController();

  String _opcionCiudad = 'Francisco Morazan';
  List<String> _ciudades = ['Francisco Morazan', 'Cortes', 'colon', 'Olancho'];
  bool _checkbox = false;

  //mirando como agregar esos iconos a las categorias
  dynamic icono1 = Icon(Icons.sports_football_sharp);
  dynamic icono2 = Icon(Icons.sports_handball_sharp);
  dynamic icono3 = Icon(Icons.sports_soccer_rounded);

  bool _showpasword = true;

  @override
  Widget build(BuildContext context) {
    final UserModel userData = ModalRoute.of(context).settings.arguments;
    if (userData != null) {
      userAccount = userData;
    }

    return Scaffold(
        body: Stack(
      children: [_createBackground(context), _crateForm(context)],
    ));
  }

  //Funcion para crear el fondo de la pantalla de login
  Widget _createBackground(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondoMorado = Container(
      height: size.height * 0.45,
      width: double.infinity,
      color: Colors.teal[300],
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );
    return Stack(
      children: [
        fondoMorado,
        Positioned(
          child: circulo,
          top: 110.0,
          left: 30.0,
        ),
        Positioned(
          child: circulo,
          top: -40.0,
          right: -30.0,
        ),
        Positioned(
          child: circulo,
          bottom: 100.0,
          right: 80.0,
        ),
        Positioned(
          child: circulo,
          bottom: -50.0,
          right: 20.0,
        ),
        Container(
          padding: EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              SizedBox(
                height: 10.0,
                width: double.infinity,
              ),
              Image(
                image: AssetImage('assets/logo.png'),
                height: 200.0,
                fit: BoxFit.cover,
              )
            ],
          ),
        )
      ],
    );
  }

  // Funcion que retorna el formulario para el apartado de inicio de sesion
  Widget _crateForm(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
            child: Container(
              height: 200.0,
            ),
          ),
          Container(
              width: size.width * 0.85,
              padding: EdgeInsets.symmetric(vertical: 20.0),
              margin: EdgeInsets.symmetric(vertical: 20.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 3.0,
                        offset: Offset(0.0, 5.0))
                  ]),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    Text(
                      'Crear cuenta',
                      style: TextStyle(
                          fontFamily: 'RobotoMono',
                          fontSize: 30.0,
                          color: Colors.lightBlue[700]),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    _createName(size.width),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    _createSurname(size.width),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    _createIdentity(size.width),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    _createEmail(size.width),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    _createPhone(size.width),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    _createBirthDate(size.width, context),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    _createPass(size.width),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    _mantenersecion(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _createBottom(context),
                  ],
                ),
              )),
          SizedBox(
            height: 10.0,
          ),
          _loginPages(context),
          SizedBox(
            height: 50.0,
          ),
        ],
      ),
    );
  }

  Widget _mantenersecion() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            focusColor: Colors.lightBlue[700],
            activeColor: Colors.lightBlue[700],
            value: _checkbox,
            onChanged: (value) {
              setState(() {
                _checkbox = !_checkbox;
              });
            },
          ),
          Text('Mantener sesion inciada'),
        ],
      ),
    );
  }

  //Crear el input para ingresar los nombres
  Widget _createName(size) {
    return Container(
        width: size * 0.8,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: TextFormField(
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            icon: Icon(
              Icons.account_box_rounded,
              color: Colors.lightBlue[700],
            ),
            hintText: 'Ejem: Juan Antonio',
            labelText: 'Primer y Segundo Nombre',
          ),
          onSaved: (value) => userAccount.nombres = value,
          validator: (value) {
            if (value.isEmpty || utils.isNumeric(value)) {
              return 'Ingrese sus nombres';
            } else {
              return null;
            }
          },
        ));
  }

  //Crear el input para ingresar los apellidos
  Widget _createSurname(size) {
    return Container(
        width: size * 0.8,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: TextFormField(
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            icon: Icon(Icons.account_circle, color: Colors.lightBlue[700]),
            hintText: 'Ejem: Perez Ramos',
            labelText: 'Primer y Segundo apellido',
          ),
          onSaved: (value) => userAccount.apellidos = value,
          validator: (value) {
            if (value.isEmpty || utils.isNumeric(value)) {
              return 'Ingrese sus apellidos';
            } else {
              return null;
            }
          },
        ));
  }

  //Crear el input para ingresar la identidad
  Widget _createIdentity(size) {
    return Container(
        width: size * 0.8,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            icon: Icon(Icons.tag, color: Colors.lightBlue[700]),
            hintText: 'Ejem: 080119992000',
            labelText: 'Numero de Identidad sin Espacios',
          ),
          onSaved: (value) => userAccount.identidad = value,
          validator: (value) {
            if (!utils.isNumeric(value) || !utils.identity(value)) {
              return 'Ingrese un número de identidad válido';
            } else {
              return null;
            }
          },
        ));
  }

  //Crear el input para ingresar el correo electronico

  Widget _createEmail(size) {
    return Container(
        width: size * 0.8,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            icon: Icon(Icons.email, color: Colors.lightBlue[700]),
            hintText: 'example@example.com',
            labelText: 'Correo Electrónico',
          ),
          onSaved: (value) => userAccount.email = value,
          validator: (value) {
            if (utils.validatorEmail(value)) {
              return null;
            } else {
              return 'Ingrese un correo válido';
            }
          },
        ));
  }

  //Crear el input para ingresar el numero de telefono
  Widget _createPhone(size) {
    return Container(
        width: size * 0.8,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            icon: Icon(Icons.phone, color: Colors.lightBlue[700]),
            hintText: 'Ejem: 88905690',
            labelText: 'Numero de telefono con código de área y sin espacios',
          ),
          onSaved: (value) => userAccount.telefono = value,
          validator: (value) {
            if (!utils.numberTel(value)) {
              return 'Ingrese un número válido';
            } else {
              return null;
            }
          },
        ));
  }

  //funcion enlazada a crear ciudades
  List<DropdownMenuItem<String>> getCityDropdown() {
    List<DropdownMenuItem<String>> listaCiudades = new List();

    _ciudades.forEach((ciudad) {
      listaCiudades.add(DropdownMenuItem(
        child: Text(ciudad),
        value: ciudad,
      ));
    });

    return listaCiudades;
  }

  //funcion de crear ciudad
  Widget _createCityDropdown(size) {
    return Container(
      child: Row(
        children: <Widget>[
          SizedBox(width: 10.0),
          Icon(Icons.room_rounded, color: Colors.lightBlue[700]),
          SizedBox(width: 15.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black38, spreadRadius: 1),
              ],
            ),
            child: Expanded(
              child: DropdownButton(
                value: _opcionCiudad,
                items: getCityDropdown(),
                onChanged: (opt) {
                  setState(() {
                    _opcionCiudad = opt;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Crear el input para ingresar la fecha de nacimiento
  Widget _createBirthDate(size, BuildContext context) {
    return Container(
        width: size * 0.8,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: TextFormField(
          enableInteractiveSelection: false,
          controller: _inputFieldDateController,
          keyboardType: TextInputType.emailAddress,
          onSaved: (value) => userAccount.fechaNac = value,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            icon: Icon(Icons.calendar_today, color: Colors.lightBlue[700]),
            labelText: 'Fecha de nacimiendo',
          ),
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            _selectDate(context);
          },
        ));
  }

  //funcion enlazada a crear fecha de nacimiento
  _selectDate(BuildContext context) async {
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    DateTime picker = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(1960, 01, 01),
        lastDate: new DateTime.now(),
        locale: Locale('es', 'ES'));

    if (picker != null) {
      setState(() {
        _fecha = formatter.format(picker).toString();//picker.toString();
        _inputFieldDateController.text = _fecha;
      });
    }
  }

  //Crear el input para ingresar la contraseña
  Widget _createPass(size) {
    return Container(
      width: size * 0.8,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: TextFormField(
        obscureText: _showpasword,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            hintText: 'Ejem: PajaroAzul1980',
            labelText: 'Al menos 8 caracteres',
            suffixIcon: GestureDetector(
              child: _showpasword ? Icon(Icons.lock) : Icon(Icons.lock_open),
              onTap: () => {
                setState(() {
                  _showpasword = !_showpasword;
                })
              },
            ),
            icon: Icon(Icons.lock, color: Colors.lightBlue[700])),
        key: keyClave,
        controller: pass1,
        onSaved: (value) => userAccount.password = value,
        validator: (value) {
          if (utils.passwordValid(value)) {
            return null;
          } else {
            return 'Mayúscula/s, minúsculas/s, número/s';
          }
        },
        //onSaved: (value) => _clave = value,
      ),
    );
  }

  //Crear el input para confirmar la contraseña

  //funcion enlazada a crear categoria
  /*List<DropdownMenuItem<String>> getCategoriaDropdown() {
    List<DropdownMenuItem<String>> listaCategorias = new List();

    _categorias.forEach((categoria) {
      listaCategorias.add(DropdownMenuItem(
        child: Text(categoria),
        value: categoria,
      ));
    });

    return listaCategorias;
  }*/

  //funcion para crear categoria
  /*Widget _createCategoriaDropdown(size) {
    return Container(
      child: Row(
        children: <Widget>[
          SizedBox(width: 10.0),
          Icon(Icons.run_circle_outlined, color: Colors.black45),
          SizedBox(width: 15.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 70.0),
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black38, spreadRadius: 1),
              ],
            ),
            child: Expanded(
              child: DropdownButton(
                value: _opcionCategoria,
                items: getCategoriaDropdown(),
                onChanged: (opt) {
                  setState(() {
                    _opcionCategoria = opt;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }*/

  Widget _loginPages(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, 'login');
      },
      child: Container(
        child: Text(
          '¿Ya tienes cuenta?',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  //Funcion que retorna el widget que almacena el boton de registrarse
  Widget _createBottom(BuildContext context) {
    return RaisedButton(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 20.0),
          child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Registrarse'),
              ])),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 5.0,
      color: Colors.red[400],
      textColor: Colors.white,
      onPressed: () => _login(context),
    );
  }

  //Funcion que se ejecuta al presionar el boton "Registrarse"
  _login(BuildContext context) async {
    //Pendiente de completacion

    if (!formkey.currentState.validate()) return;
    formkey.currentState.save();
    dynamic result = await _auth.registerUser(userAccount, _checkbox);
    if (result['ok']) {
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      final data = {"msj": result['error']};
      mostrarAlerta(context, data);
    }
  }
}
