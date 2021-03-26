import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:runxatruch_app/models/user_models.dart';
import 'package:runxatruch_app/provider/events_provider.dart';
import 'package:runxatruch_app/models/events_model.dart';

class CareersPages extends StatefulWidget {
  const CareersPages({Key key}) : super(key: key);

  @override
  _CareersPagesState createState() => _CareersPagesState();
}

double heightScreen, widthScreen;
bool _filter = false;

class _CareersPagesState extends State<CareersPages> {
  @override
  Widget build(BuildContext context) {
    heightScreen = MediaQuery.of(context).size.height;
    widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _createBody(),
    );
  }

  Widget _createBody() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      margin: EdgeInsets.only(top: heightScreen * 0.09),
      child: Column(
        children: [
          _menuFilter(),
          _createListEvent(),
          _createListEvent(),
        ],
      ),
    );
  }

  Widget _menuFilter() {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Text("HELLO"),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Text("HELLO"),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Text("HELLO"),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Text("HELLO"),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Text("HELLO"),
            )
          ],
        ),
      ),
    );
  }

  Widget _createFilter() {
    if (!_filter) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Filtrar"),
          IconButton(
            onPressed: () {
              _filter = !_filter;
              setState(() {});
            },
            icon: Icon(
              Icons.arrow_downward,
              color: Colors.red[400],
            ),
          ),
        ],
      );
    } else {
      return Container(
        child: Text("filtar"),
      );
    }
  }

  Widget _createListEvent() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 1,
            offset: Offset(0, 3), // changes position of shadow
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
                    image: AssetImage("assets/event.png"),
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
                    Divider(),
                    Row(
                      children: [
                        Text(
                          "Nombre:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red[400]),
                        ),
                        Text("Hola Hola como estas")
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Text(
                          "Fecha:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red[400]),
                        ),
                        Text("25/03/2025")
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: widthScreen * 0.7),
            child: Row(
              children: [
                Text(
                  "Ver mas",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.red[400]),
                ),
                IconButton(
                    icon: Icon(Icons.arrow_forward_ios_outlined,
                        color: Colors.red[400]),
                    onPressed: () => print("mas")),
              ],
            ),
          )
        ],
      ),
    );
  }
}
