import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:runxatruch_app/models/events_inscription_model.dart';
import 'package:runxatruch_app/models/events_model.dart';
import 'package:runxatruch_app/provider/events_provider.dart';
import 'package:runxatruch_app/provider/incription_provider.dart';

import 'careers_page.dart';

class ToRunPage extends StatefulWidget {
  const ToRunPage({Key key}) : super(key: key);

  @override
  _ToRunPage createState() => _ToRunPage();
}

class _ToRunPage extends State<ToRunPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    heightScreen = MediaQuery.of(context).size.height;
    widthScreen = MediaQuery.of(context).size.width;
    //data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Mis Eventos'),
      ),
      body: _bodyCreate(),
    );
  }

  Widget _bodyCreate() {
    return Container(
      child: Column(
        children: [
          Container(
              child: Center(
            child: Text(
              'Si desea eliminar una inscripción, deslice sobre el evento',
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.red[400],
                  fontWeight: FontWeight.bold),
            ),
          )),
          _showEvent()
        ],
      ),
    );
  }

//mostrar eventos de usuario

  Widget _showEvent() {
    final _eventprovider = new EventProvider();

    return FutureBuilder(
      future: _eventprovider.getEventsInscription(),
      builder:
          (BuildContext context, AsyncSnapshot<List<EventModelUser>> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          if (data.length > 0) {
            return Expanded(
              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, i) {
                    final item = data[i].idInscription;
                    final name = data[i].nameEvent;
                    //return _createListEvent(data[i], context);
                    return Dismissible(
                      key: Key(item),
                      onDismissed: (direction) {
                        _deleteInscription(data[i].idInscription);
                        setState(() {
                          data.removeAt(i);
                        });

                        // Then show a snackbar.
                        Scaffold.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red[400],
                            content: Text(
                              "Ya no está inscrito en el evento: $name",
                              style: TextStyle(color: Colors.white),
                            )));
                      },
                      // Show a red background as the item is swiped away.
                      background: Container(
                        child: Image(
                          image: AssetImage("assets/delete.png"),
                        ),
                      ),
                      //child: ListTile(title: Text('$item')),
                      child: _createListEvent(data[i], context),
                    );
                  }),
            );
          } else {
            return Container(
              margin: EdgeInsets.only(top: 300),
              child: Center(
                child: Text("No se encontraron eventos"),
              ),
            );
          }
        } else {
          return Container(
            margin: EdgeInsets.only(top: 300),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _createListEvent(EventModelUser data, BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 10, right: 10, left: 10),
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[100],
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                spreadRadius: 3,
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 12),
                      child: Image(
                        image: AssetImage("assets/calender.png"),
                        width: 45,
                      )),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: widthScreen * 0.7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              "Evento: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.red[400]),
                            ),
                            Text(data.nameEvent)
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              "Fecha: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.red[400]),
                            ),
                            Text(data.startTime)
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              "Ciudad: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.red[400]),
                            ),
                            Text(data.city)
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              _dataCategory(data.categories),
            ],
          ),
        ),
      ],
    );
  }

  Widget _dataCategory(List<dynamic> categories) {
    var catIncrita;

    for (var i = 0; i < categories.length; i++) {
      if (categories[i]['inscrito'] == true) {
        catIncrita = i;
      }
    }
    return Container(
      //width: widthScreen * 0.6,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Divider(color: Colors.black),
          Row(
            children: [
              Icon(Icons.category),
              Text(
                'Categoria: ',
                style: TextStyle(
                    fontStyle: FontStyle.italic, color: Colors.red[400]),
              ),
              Text(categories[catIncrita]['nameCategory'].toString()),
              SizedBox(
                width: 20,
              ),
              Icon(Icons.directions_run),
              Text(categories[catIncrita]['km'].toString()),
              Text(
                ' km',
                style: TextStyle(
                    color: Colors.red[400], fontStyle: FontStyle.italic),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock_clock),
              Text(
                'Dias Restantes: ',
                style: TextStyle(
                    color: Colors.red[400], fontStyle: FontStyle.italic),
              ),
              Text('2')
            ],
          )
        ],
      ),
    );
  }

  _deleteInscription(String id) {
    final result = InscriptionProvider().deleteUser(id);
    result.then((resp) => {print(result)});
  }

  Future<void> obtenerData() async {
    print("refescar");
    final duration = new Duration(microseconds: 200);
    new Timer(duration, () {
      setState(() {});
    });
  }
}
