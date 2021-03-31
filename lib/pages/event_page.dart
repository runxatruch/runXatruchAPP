import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:runxatruch_app/bloc/mapa/mapa_bloc.dart';
import 'package:runxatruch_app/models/events_model.dart';
import 'package:runxatruch_app/models/route_model.dart';
import 'package:runxatruch_app/provider/events_provider.dart';

import 'careers_page.dart';
import 'map_page.dart';

class EventPages extends StatefulWidget {
  const EventPages({Key key}) : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

String categoriaSelect;

class _EventPageState extends State<EventPages> {
  @override
  Widget build(BuildContext context) {
    EventModel data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text(data.nameEvent),
        ),
        body: SingleChildScrollView(
          child: _bodyCreate(data),
        ));
  }

  Widget _bodyCreate(EventModel data) {
    _categoryName = [];

    for (var i = 0; i < data.categories.length; i++) {
      _categoryName.add(data.categories[i]['nameCategory']);
    }
    return Container(
      child: Column(
        children: [
          _dataEvent(data),
          SizedBox(height: 10),
          _category(data.categories),
          // Divider(
          //   color: Colors.black,
          //   thickness: 3.0,
          // ),
          SizedBox(height: 10),
          _showCategory(data.categories)
        ],
      ),
    );
  }

  var _categoryName = [""];
  String _categoryCurrent;

  Widget _category(List categories) {
    //_categoryCurrent = _categoryName[0];
    return Container(
      width: widthScreen,
      height: 65,
      padding: EdgeInsets.only(top: 5),
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
                labelText: "Cambiar Categoria",
                errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                hintText: 'Please select expense',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0))),
            isEmpty: _categoryCurrent == '',
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _categoryCurrent,
                isDense: true,
                onChanged: (String newValue) {
                  setState(() {
                    _categoryCurrent = newValue;
                    state.didChange(newValue);
                    _showCategory(categories);
                  });
                },
                items: _categoryName.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _showCategory(List categories) {
    final rnd = new Random();
    final width = rnd.nextInt(30) + widthScreen;
    final r = rnd.nextInt(255);
    final g = rnd.nextInt(255);
    final b = rnd.nextInt(255);
    int cat = 0;
    for (var i = 0; i < categories.length; i++) {
      if (categories[i]['nameCategory'] == _categoryCurrent) {
        //aqui va current
        cat = i;
      }
      // }
    }

    return PhysicalModel(
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        color: Colors.white,
        // decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //         colors: [Colors.blueGrey[50], Colors.blue, Colors.red[100]],
        //         stops: [0.5, 0.5, 0.3],
        //         end: FractionalOffset.bottomCenter)),
        width: width.toDouble(),
        curve: Curves.elasticOut,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: widthScreen * 0.9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(Icons.category),
                          Text(
                            "Categoria: ",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.red[400],
                              fontStyle: FontStyle.italic,
                              fontSize: 18.0,
                            ),
                            textAlign: TextAlign.end,
                          ),
                          SizedBox(width: 10),
                          Text(
                            categories[cat]['nameCategory'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                //color: Colors.red[400]
                                fontSize: 18.0),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(Icons.compare_arrows_sharp),
                          Text(
                            "Premios: ",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.red[400],
                              fontStyle: FontStyle.italic,
                              fontSize: 18.0,
                            ),
                          ),
                          SizedBox(width: 18),
                          Text(categories[cat]['prize'].toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(Icons.verified_user_sharp),
                          Text(
                            "Edad: ",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.red[400],
                              fontStyle: FontStyle.italic,
                              fontSize: 18.0,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                              categories[cat]['ageMin'] +
                                  " - " +
                                  categories[cat]['ageMax'] +
                                  " años",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(Icons.directions_run),
                          Text(
                            "kilómetros a recorrer: ",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.italic,
                                fontSize: 18.0,
                                color: Colors.red[400]),
                          ),
                          SizedBox(width: 18),
                          Text(categories[cat]['km'].toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Icon(Icons.directions),
                      Text(
                        "Ruta a Seguir: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red[400]),
                      ),
                      SizedBox(height: 50),
                      _createMap(categories[cat]),
                      SizedBox(height: 50),
                      _inscribir(categories[cat]['admitido'].toString()),
                      SizedBox(height: 90),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      elevation: 15.0,
      color: Colors.black,
      shape: BoxShape.circle,
      shadowColor: Colors.redAccent,
    );
    //return Container(child: Text(cat.toString()));
  }

  Widget _inscribir(String admit) {
    if (admit.toString() == 'true') {
      return Container(
          width: 150.0,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.red,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.zero,
              bottomLeft: Radius.zero,
              bottomRight: Radius.zero,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Inscribirme',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  fontStyle: FontStyle.normal,
                  fontSize: 18.0,
                ),
              ),
              Icon(Icons.add_circle)
            ],
          ));
    } else {
      return Text(
        'Su edad no es admitida para esta categoria',
        style: TextStyle(
          fontWeight: FontWeight.normal,
          color: Colors.red[400],
          fontStyle: FontStyle.italic,
          fontSize: 14.0,
        ),
      );
    }
  }

  Widget _dataEvent(EventModel data) {
    return Container(
      padding: EdgeInsets.only(top: heightScreen * 0.04, bottom: 10),
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
            color: Colors.black54, blurRadius: 2.0, offset: Offset(0.1, 0.5))
      ], color: Colors.white),
      child: Column(
        children: [
          Text(
            data.descripEvent,
            textAlign: TextAlign.center,
          ),
          Divider(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: <Widget>[
                Container(
                    //margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                  children: [
                    Text(
                      "Ciudad: ",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.red[400]),
                    ),
                    Text(data.city),
                  ],
                )),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      "Inicia: ",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.red[400]),
                    ),
                    Text(data.startTime.substring(0, 10)),
                    Text(
                      " Hora: ",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.red[400]),
                    ),
                    Text(data.startTime.substring(11, 16)),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      "Finaliza: ",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.red[400]),
                    ),
                    Text(
                      data.endTime.substring(0, 10),
                    ),
                    Text(
                      " Hora: ",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.red[400]),
                    ),
                    Text(data.endTime.substring(11, 16)),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        // Text(
                        //   "Descripción: ",
                        //   style: TextStyle(
                        //       fontWeight: FontWeight.bold,
                        //       color: Colors.red[400]),
                        // ),
                        // Text(
                        //   data.descripEvent,
                        //   textAlign: TextAlign.end,
                        // ),
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //Generar mapa con la ruta
  Widget _createMap(categories) {
    List<LatLng> route = [];
    return FutureBuilder(
      future: EventProvider().category(categories['id']),
      builder: (BuildContext context, AsyncSnapshot<RuteModel> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          route.clear();

          for (var item in data.rute) {
            if (item["log"] != null || item["lat"] != null) {
              LatLng ite = new LatLng(double.parse(item["lat"].toString()),
                  double.parse(item["log"].toString()));
              route.add(ite);
            }
          }

          return Container(
            height: heightScreen * 0.5,
            width: widthScreen,
            child: MapPage(
              route: route,
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
