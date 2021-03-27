import 'package:flutter/material.dart';
import 'package:runxatruch_app/models/events_model.dart';

import 'careers_page.dart';

class EventPage extends StatelessWidget {
  const EventPage({Key key}) : super(key: key);

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

  Widget _bodyCreate(data) {
    return Container(
      child: Column(
        children: [
          _dataEvent(data),
          //  _showCategory()
        ],
      ),
    );
  }
// Widget _showCategory() {
//     return FutureBuilder(
//       //future: _eventprovider.getEvents(),
//       builder:
//           (BuildContext context, AsyncSnapshot<List<EventModel>> snapshot) {
//         if (snapshot.hasData) {
//           final data = snapshot.data;
//           if (data.length > 0) {
//             return Expanded(
//               child: ListView.builder(
//                   itemCount: data.length,
//                   itemBuilder: (context, i) =>
//                       _createListEvent(data[i], context)),
//             );
//           } else {
//             return Center(
//               child: Text("No se encontraron eventos"),
//             );
//           }
//         } else {
//           return Container(
//             margin: EdgeInsets.only(top: 300),
//             child: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         }
//       },
//     );
//   }

  Widget _createListEvent() {}

  Widget _dataEvent(data) {
    return Container(
      padding: EdgeInsets.only(top: heightScreen * 0.09, bottom: 10),
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
          Text("Detalle evento"),
          Divider(),
          SingleChildScrollView(
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
