import 'package:flutter/material.dart';
import 'package:runxatruch_app/Widget/btnMap.dart';
import 'package:runxatruch_app/pages/map_page.dart';

class PreparationPages extends StatelessWidget {
  const PreparationPages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 80),
              child: Column(
                children: [
                  _cronometro(),
                  SizedBox(
                    height: 40,
                  ),
                  _createInformation()
                ],
              ),
            ),
            Divider(),
            GestureDetector(
              onTap: () => print('presiono'),
              child: Container(
                width: size.width * 1,
                height: size.height * 0.595,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset.zero, //(x,y)
                        blurRadius: 2.0,
                      )
                    ]),
                child: MapPage(),
              ),
            )
          ],
        ),
        floatingActionButton: BTNmap());
  }

  Widget _cronometro() {
    return Center(
      child: Column(
        children: [
          Text(
            '00:00:00',
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text('Duracion')
        ],
      ),
    );
  }

  Widget _createInformation() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_createDistan(), _createRitmo()],
      ),
    );
  }

  Widget _createDistan() {
    return Column(
      children: [
        Text(
          '0,00',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Text('Distancia (km)')
      ],
    );
  }

  Widget _createRitmo() {
    return Column(
      children: [
        Text(
          '0,00',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'Distancia (km)',
        )
      ],
    );
  }
}
