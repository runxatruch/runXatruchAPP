import 'package:flutter/material.dart';
import 'package:runxatruch_app/pages/careers_page.dart';

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
      body: SingleChildScrollView(
        child: _bodyCreate(),
      ),
    );
  }

  Widget _bodyCreate() {
    return Container(
      padding: EdgeInsets.only(top: 5, left: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              blurRadius: 10, color: Colors.redAccent, offset: Offset(8, 8))
        ],
      ),
      alignment: Alignment.center,
      margin: EdgeInsets.all(25),
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
              Icon(Icons.event),
              Text('Evento: '),
              Text('Nombre Evento')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.date_range_sharp),
              Text('Fecha: '),
              Text('14/04/2021')
            ],
          ),
          SizedBox(
            height: 2,
          ),
          Row(
            children: [
              Icon(Icons.star_rate_outlined),
              Text('Premio: '),
              Text('Segundo Lugar'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.timelapse_sharp),
              Text('Tiempo: '),
              Text('1:10:07')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.timelapse_sharp),
              Text('Categoría: '),
              Text('Nombre Categoria')
            ],
          )
        ],
      ),
    );
  }
}
