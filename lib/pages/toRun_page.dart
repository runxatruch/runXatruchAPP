import 'dart:convert';
import 'package:flutter/foundation.dart';
//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:runxatruch_app/models/events_model.dart';
import 'package:runxatruch_app/provider/events_provider.dart';

import 'careers_page.dart';

class ToRunPage extends StatefulWidget {
  const ToRunPage({Key key}) : super(key: key);

  @override
  _ToRunPage createState() => _ToRunPage();
}

class _ToRunPage extends State<ToRunPage> {
  @override
  Widget build(BuildContext context) {
    heightScreen = MediaQuery.of(context).size.height;
    widthScreen = MediaQuery.of(context).size.width;
    //data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
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
          (BuildContext context, AsyncSnapshot<List<EventModel>> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          if (data.length > 0) {
            return Expanded(
              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, i) {
                    final item = data[i].id;
                    final name = data[i].nameEvent;
                    //return _createListEvent(data[i], context);
                    return Dismissible(
                      // Each Dismissible must contain a Key. Keys allow Flutter to
                      // uniquely identify widgets.
                      key: Key(item),
                      // Provide a function that tells the app
                      // what to do after an item has been swiped away.
                      onDismissed: (direction) {
                        // Remove the item from the data source.
                        setState(() {
                          data.removeAt(i);
                          //eliminar de la base de datos
                        });

                        // Then show a snackbar.
                        Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "Ya no está inscrito en el evento: $name")));
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
            return Center(
              child: Text("No se encontraron eventos"),
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

  Widget _createListEvent(EventModel data, BuildContext context) {
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
        Divider(
          color: Colors.red,
          thickness: 3.0,
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
}
