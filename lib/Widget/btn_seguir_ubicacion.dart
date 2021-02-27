part of 'widgets.dart';

class BtnMiRuta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final mapaBloc = BlocProvider.of<MapaBloc>(context);

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(Icons.more_horiz, color: Colors.black87),
          onPressed: () {
            for (var item in mapaBloc.state.polylines.values) {
              print('*********');
              print(item.points);
            }
            mapaBloc.add(OnMarcarRecorrido());
          },
        ),
      ),
    );
  }
}
