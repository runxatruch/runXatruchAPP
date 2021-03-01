import 'package:flutter/material.dart';
import 'package:runxatruch_app/models/trainingUser_model.dart';
import 'package:runxatruch_app/provider/user_provider.dart';

class HistorialTraining extends StatelessWidget {
  const HistorialTraining({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Historial'),
        ),
        body: Container(
          child: FutureBuilder(
            future: UserProvider().getRouteUser(),
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
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        child: Icon(
          Icons.delete_sweep_outlined,
          color: Colors.red,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    child: Column(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text('${date.day}/${date.month}/${date.year}',
                            style: TextStyle(
                                fontSize: 20, color: Colors.red[400])),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              '${tarining.km}  Km',
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Text(
                              '${tarining.speed} Km/h',
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Text('${tarining.time}',
                                style: TextStyle(fontSize: 15))
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_rounded, size: 40),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
