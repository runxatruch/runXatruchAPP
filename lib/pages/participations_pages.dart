import 'package:flutter/material.dart';
import 'package:runxatruch_app/provider/incription_provider.dart';

class ParticipationsPage extends StatelessWidget {
  const ParticipationsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List producto = new List();
    final podData = ModalRoute.of(context).settings.arguments;
    if (podData != null) {
      producto = podData;
      print(producto);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Participaciones'),
      ),
      body: Container(
        child: FutureBuilder(
          future: InscriptionProvider().showPartipation(),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data;
              print("********** $data");
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, i) => _bodyCreate(data[i], context));
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _bodyCreate(Map<dynamic, dynamic> data, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15, left: 6, bottom: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.red[400])),
      alignment: Alignment.center,
      margin: EdgeInsets.all(15),
      width: 400,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 12),
                  child: Image(
                    image: AssetImage("assets/run.png"),
                    width: 45,
                  )),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 250,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.event_available_outlined,
                            color: Colors.red[200]),
                        Text('Evento: ',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent)),
                        Text('${data["nameEvent"]}')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.date_range_sharp, color: Colors.red[200]),
                        Text(' Fecha: ',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent)),
                        Text('${data["date"].split("T")[0]}')
                      ],
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        Icon(Icons.arrow_right_alt_outlined,
                            color: Colors.red[200]),
                        Text(
                          ' Km: ',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent),
                        ),
                        Text('${data["kmTotal"]}'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.adjust_outlined, color: Colors.red[200]),
                        Text(
                          ' Estado: ',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent),
                        ),
                        Text('${data["state"]}'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.timelapse_sharp, color: Colors.red[200]),
                        Text('Tiempo: ',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent)),
                        Text('${data["timeTotal"]}')
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
