import 'package:flutter/material.dart';
import 'package:runxatruch_app/models/trainingUser_model.dart';
import 'package:runxatruch_app/provider/user_provider.dart';

class HistorialTraining extends StatefulWidget {
  const HistorialTraining({Key key}) : super(key: key);

  @override
  _HistorialTrainingState createState() => _HistorialTrainingState();
}

class _HistorialTrainingState extends State<HistorialTraining> {
  int mes = DateTime.now().month;
  List<String> meses = [
    'Enero',
    'Febreo',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre'
  ];
  List<String> mesesData = [];

  String dropdownValue = "";
  final futureHistori = UserProvider().getRouteUser();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.red[400]),
          backgroundColor: Colors.white,
          title: Text(
            'Historial',
            style: TextStyle(color: Colors.red[400]),
          ),
          actions: [_createMenu()],
        ),
        body: Container(
          child: FutureBuilder(
            future: futureHistori,
            builder: (BuildContext context,
                AsyncSnapshot<List<TrainingModel>> snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data;
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, i) => _crearItem(data[i], context));
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ));
  }

  Widget _crearItem(TrainingModel tarining, BuildContext context) {
    DateTime date = DateTime.parse(tarining.date);
    if (meses[date.month - 1] == dropdownValue) {
      final size = MediaQuery.of(context).size;
      return Dismissible(
        key: UniqueKey(),
        background: Container(
          child: Icon(
            Icons.delete_sweep_outlined,
            color: Colors.red[400],
          ),
        ),
        onDismissed: (DismissDirection direction) {
          print('eliminar');
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: Text('${date.day}/${date.month}/${date.year}',
                            style: TextStyle(
                                fontSize: 15, color: Colors.red[400])),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: size.width * 0.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image(
                                      image: AssetImage("assets/ubicacion.png"),
                                      height: 25,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '${tarining.km}  Km',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Image(
                                      image: AssetImage("assets/hora.png"),
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('${tarining.time} min',
                                        style: TextStyle(fontSize: 13)),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Row(
                              children: [
                                Image(
                                  image: AssetImage("assets/velocimetro.png"),
                                  height: 20,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${tarining.speed} Km/h',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _createMenu() {
    futureHistori.then((e) {
      for (TrainingModel item in e) {
        DateTime date = DateTime.parse(item.date);
        _setmeses(date.month);
      }
    });
    if (dropdownValue == '') {
      mesesData.add(meses[mes - 1]);
      dropdownValue = meses[mes - 1];
    }
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(
        Icons.arrow_downward,
        color: Colors.red[400],
      ),
      iconSize: 24,
      style: TextStyle(color: Colors.white),
      elevation: 16,
      underline: Container(
        height: 3,
        color: Colors.red[400],
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: mesesData.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(color: Colors.red),
          ),
        );
      }).toList(),
    );
  }

  _setmeses(int mes) {
    for (var i in mesesData) {
      if ((i == meses[mes - 1])) {
        return;
      }
    }
    mesesData.add(meses[mes - 1]);
    setState(() {});
  }
}
