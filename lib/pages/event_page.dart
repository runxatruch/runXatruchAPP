import 'package:flutter/material.dart';
import 'package:runxatruch_app/models/events_model.dart';

import 'careers_page.dart';

class EventPages extends StatefulWidget {
  const EventPages({Key key}) : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPages> {
  @override
  Widget build(BuildContext context) {
    EventModel data = ModalRoute.of(context).settings.arguments;

    print(data.categories);
    return Scaffold(
      appBar: AppBar(
        title: Text(data.nameEvent),
      ),
      body: _bodyCreate(data),

      //  Container(
      //     margin: EdgeInsets.only(left: widthScreen * 0.65),
      //      child: Row(
      //       children: [
      //         Text(
      //           "Ver mas",
      //           style: TextStyle(
      //               fontWeight: FontWeight.bold, color: Colors.red[400]),
      //         ),
      //         IconButton(
      //             icon: Icon(Icons.arrow_forward_ios_outlined,
      //                 color: Colors.red[400]),
      //             onPressed: () =>
      //                 Navigator.pushNamed(context, 'event', arguments: data)
      //             ),
      //       ],
      //      ),
      //      //_showDetail()
      //    ),
    );
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
          _category(data.categories),
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
      width: widthScreen * 0.9,
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
                  });
                  _showCategory(categories);
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
    int cat = 0;
    for (var i = 0; i < categories.length; i++) {
      if (categories[i]['nameCategory'] == _categoryCurrent) {
        //aqui va current
        cat = i;
      }
      // }
    }
    return Container(
      margin: EdgeInsets.only(top: 10, right: 10, left: 10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.zero,
        color: Color.fromRGBO(253, 253, 253, 1),
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
                    image: AssetImage("assets/lugares.jpg"),
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
                        Text("Categoria: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red[400],
                                fontSize: 18.0)),
                        Text(
                          categories[cat]['nameCategory'].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              //color: Colors.red[400]
                              fontSize: 23.0),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          "Premios: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red[400]),
                        ),
                        Text(categories[cat]['prize'].toString())
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          "Rango de Edad admitido: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red[400]),
                        ),
                        Text(categories[cat]['ageMin'] +
                            " - " +
                            categories[cat]['ageMax'] +
                            " años")
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          "kilómetros a recorrer: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red[400]),
                        ),
                        Text(categories[cat]['km'].toString())
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Ruta a Seguir: ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red[400]),
                    ),
                    SizedBox(
                        height: 50,
                        child: Center(
                          child: Text('Aquí va el mapa'),
                        ))
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
    //return Container(child: Text(cat.toString()));
  }
  // Widget _showCategory(List categories) {
  //   return FutureBuilder(
  //     //future: _eventprovider.getEvents(),
  //     builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
  //       if (categories.length > 0) {
  //         final data = categories;
  //         if (data.length > 0) {
  //           return Expanded(
  //             child: ListView.builder(
  //                 itemCount: data.length,
  //                 itemBuilder: (context, i) =>
  //                     _createListEvent(data[i], context)),
  //           );
  //         } else {
  //           return Center(
  //             child: Text("No se encontraron Categorias"),
  //           );
  //         }
  //       } else {
  //         print('jmmm');
  //         return Container(
  //           margin: EdgeInsets.only(top: 300),
  //           child: Center(
  //             child: CircularProgressIndicator(),
  //           ),
  //         );
  //       }
  //     },
  //   );
  // }

  Widget _createListEvent(Map cat, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, right: 10, left: 10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromRGBO(253, 253, 253, 1),
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
                    image: AssetImage("assets/lugares.jpg"),
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
                        Text("Categoria: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red[400],
                                fontSize: 18.0)),
                        Text(
                          cat['nameCategory'].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              //color: Colors.red[400]
                              fontSize: 23.0),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          "Premios: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red[400]),
                        ),
                        Text(cat['prize'].toString())
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          "Rango de Edad admitido: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red[400]),
                        ),
                        Text(cat['ageMin'] + " - " + cat['ageMax'] + " años")
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          "kilómetros a recorrer: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red[400]),
                        ),
                        Text(cat['km'].toString())
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Ruta a Seguir: ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red[400]),
                    ),
                    SizedBox(
                        height: 50,
                        child: Center(
                          child: Text('Aquí va el mapa'),
                        ))
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _dataEvent(EventModel data) {
    return Container(
      padding: EdgeInsets.only(top: heightScreen * 0.04, bottom: 10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.red[400])),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54,
                blurRadius: 5.0,
                offset: Offset(0.0, 0.5))
          ],
          color: Colors.white),
      child: Column(
        children: [
          Text("Detalle Evento"),
          Divider(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          "Se llevará a cabo en: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
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
                      "Dará Inicio el: ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red[400]),
                    ),
                    Text(data.startTime.substring(0, 10)),
                    Text(
                      " Hora: ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red[400]),
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
                      "Finaliza el: ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red[400]),
                    ),
                    Text(data.endTime.substring(0, 10)),
                    Text(
                      " Hora: ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red[400]),
                    ),
                    Text(data.endTime.substring(11, 16)),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
