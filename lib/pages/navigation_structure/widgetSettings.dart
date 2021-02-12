import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WidgetSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //1. SilverApp sustituimos el contenido por un CustomScrollView
    /*
        SilverAppbar: Appbar con funcionadidades customizables. Integra un 
        ScrollView que permite ampliar o desampliar dicha zona.
      */
    //2. SilverApp, eliminamos el AppBar de la pantalla principal.
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 100,
          floating: false,
          pinned: false,
          snap: false,
          title: Text("Perfil"),
          /*actions: [
            IconButton(
              icon: Icon(Icons.keyboard_backspace_sharp),
            )
          ],
          */
          bottom: PreferredSize(
             child: Icon(Icons.person_sharp),
              preferredSize: Size.fromHeight(1)),
         
         /* flexibleSpace: FlexibleSpaceBar(
            title: Text("Perfil"),
          ),
          */

        ),
        SliverList(
          delegate: SliverChildListDelegate([
            ListTile(title: Text("item")),
            ListTile(title: Text("item")),
            ListTile(title: Text("item")),
            ListTile(title: Text("item")),
            ListTile(title: Text("item")),
            ListTile(title: Text("item")),
            ListTile(title: Text("item")),
            ListTile(title: Text("item")),
            ListTile(title: Text("item")),
          ]),
        )
      ],
    );
  }
}
