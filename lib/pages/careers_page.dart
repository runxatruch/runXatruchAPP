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
  final _eventprovider = new EventProvider();
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
      child: Column(
        children: [_menuFilter(), _createListEvent(), _createListEvent()],
      ),
    );
  }

  Widget _menuFilter() {
    return Container(
      padding: EdgeInsets.only(top: heightScreen * 0.09, bottom: 10),
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
            color: Colors.black54, blurRadius: 9.0, offset: Offset(0.0, 0.75))
      ], color: Colors.white),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                _createCity(),
                _createCity(),
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
        ],
      ),
    );
  }

  // Widget _showEvent() {
  //   FutureBuilder(
  //     future: _eventprovider.getEvents(),
  //     builder:
  //         (BuildContext context, AsyncSnapshot<List<EventModel>> snapshot) {
  //       if (snapshot.hasData) {
  //         final data = snapshot.data;
  //         return ListView.builder(
  //             itemCount: data.length,
  //             itemBuilder: (context, i) => _createListEvent(data[i], context));
  //       } else {
  //         return Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }
  //     },
  //   );
  // }

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

  var _currencies = [
    "Food",
    "Transport",
    "Personal",
    "Shopping",
    "Medical",
    "Rent",
    "Movie",
    "Salary"
  ];
  String _currentSelectedValue;

  Widget _createCity() {
    return Container(
      width: widthScreen * 0.4,
      height: 65,
      padding: EdgeInsets.only(top: 5),
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
                labelText: "Ciudad",
                errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                hintText: 'Please select expense',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0))),
            isEmpty: _currentSelectedValue == '',
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _currentSelectedValue,
                isDense: true,
                onChanged: (String newValue) {
                  setState(() {
                    _currentSelectedValue = newValue;
                    state.didChange(newValue);
                  });
                },
                items: _currencies.map((String value) {
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
}
