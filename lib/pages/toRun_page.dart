import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:runxatruch_app/models/events_inscription_model.dart';
import 'package:runxatruch_app/models/events_model.dart';
import 'package:runxatruch_app/pages/competition_page.dart';
import 'package:runxatruch_app/provider/events_provider.dart';
import 'package:runxatruch_app/provider/incription_provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'timer.dart';

import 'package:timer_builder/timer_builder.dart';

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
          _showEvent(),
          // StatusIndicator(DateTime.now(), DateTime.parse('2021-04-30T08:00'))
          //Text('reloj')
          //timer()
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
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        _deleteInscription(data[i].idInscription);
                        setState(() {
                          data.removeAt(i);
                        });

                        // Then show a snackbar.
                        Scaffold.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.white,
                            content: Text(
                              "Ya no está inscrito en el evento: $name",
                              style: TextStyle(color: Colors.white),
                            )));
                      },
                      // Show a red background as the item is swiped away.
                      background: Container(
                          child: Icon(
                        Icons.delete_sweep_outlined,
                        color: Colors.red,
                      )),
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
                            Text(data.city),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              _dataCategory(data.categories, data.startTime, data),
            ],
          ),
        ),
      ],
    );
  }

  Widget _dataCategory(
      List<dynamic> categories, String dateEvent, EventModelUser dataEvent) {
    print(dateEvent);
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              days(dateEvent),
              SizedBox(
                width: widthScreen * 0.22,
              ),
              timer(dateEvent, dataEvent, categories[catIncrita]),
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

  Widget days(String date) {
    DateTime dates = DateTime.parse(date);
    final dateNow = DateTime.now();
    final difference = dates.difference(dateNow).inDays;
    if (difference >= 1) {
      return Row(
        children: [
          SizedBox(
            width: widthScreen * 0.2,
          ),
          Icon(Icons.lock_clock),
          Text(
            'Dias Restantes: ',
            style:
                TextStyle(color: Colors.red[400], fontStyle: FontStyle.italic),
          ),
          Text(difference.toString()),
        ],
      );
    } else {
      return Text('');
    }
  }

//prueba
  Widget timer(String dateEvent, EventModelUser event, dynamic category) {
    //dateEvent = '2021-04-11T03:55';
    DateTime date = DateTime.parse(dateEvent);
    final dateNow = DateTime.now();

    final difference = date.difference(dateNow);
    print(difference);

    int second = difference.inSeconds;
    int minute = difference.inMinutes;
    int hour = difference.inHours - 1;
    DateTime dates;
    dates = DateTime.now()
        .add(Duration(hours: hour, minutes: minute, seconds: second));
    // }
    print(difference.inDays);
    if (difference.inDays < 1) {
      return Container(
        width: 220,
        child: TimerBuilder.scheduled([date], builder: (context) {
          // This function will be called once the alert time is reached
          //
          var now = DateTime.now();
          var reached = now.compareTo(dates) >= 0;
          final textStyle = Theme.of(context).textTheme.title;
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  reached ? Icons.alarm_on : Icons.alarm,
                  color: reached ? Colors.red : Colors.red,
                  size: 33,
                ),
                !reached
                    ? TimerBuilder.periodic(Duration(seconds: 1),
                        alignment: Duration.zero, builder: (context) {
                        // This function will be called every second until the alert time
                        var now = DateTime.now();

                        var remaining = date.difference(now);
                        return Text(
                          formatDuration(remaining),
                          style: textStyle,
                        );
                      })
                    : Text("Tiempo!", style: textStyle),
                start(event, category),
              ],
            ),
          );
        }),
      );
    } else {
      return Text('');
    }
  }

  Widget start(EventModelUser event, dynamic category) {
    event.categories = [];
    event.categories.add(category);
    return RaisedButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
        elevation: 5.0,
        color: Colors.red[400],
        textColor: Colors.white,
        child: Text('Competir'),
        onPressed: () => {
              setState(() {
                //runApp(ProviderScope(child: CompetityPage()))

                Navigator.pushNamed(context, 'startRun', arguments: event);
              })
              //runApp(ProviderScope(child: CompetityPage())),
            });
  }

  String formatDuration(Duration d) {
    String f(int n) {
      return n.toString().padLeft(2, '0');
    }

    // We want to round up the remaining time to the nearest second
    d += Duration(microseconds: 999999);
    return "${f(d.inHours)}:${f(d.inMinutes % 60)}:${f(d.inSeconds % 60)}";
  }
}
