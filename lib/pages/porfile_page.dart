import 'package:flutter/material.dart';
import 'package:runxatruch_app/prefUser/preferent_user.dart';
import 'package:runxatruch_app/provider/user_provider.dart';

import '../provider/auth_provider.dart';

class PorfilePage extends StatelessWidget {
  const PorfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider _prov = UserProvider();
    dynamic result = _prov.getDataUser();

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Ajustes',
            onPressed: () => Navigator.pushNamed(context, 'setting'),
          )
        ],
        elevation: 0.0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Container(
            height: size.height * 0.35,
            child: _createPorfile(size.height),
          ),
          SizedBox(
            height: 20,
          ),
          Text('Datos Personales'),
          Divider(),
          _createedad(),
          SizedBox(
            height: 10,
          ),
          _createIdenty(),
          SizedBox(
            height: 40,
          ),
          Text('Participaciones'),
          Divider(),
          _createPart(),
          SizedBox(
            height: 40,
          ),
          Text('Soporte'),
          Divider(),
          _createSuport(),
          SizedBox(
            height: 20,
          ),
          _createFooter(context)
        ],
      ),
    );
  }

  Widget _createPorfile(size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/unnamed.png',
          height: size * 0.2,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Angel Gabriel Chavez Vigil',
          style: TextStyle(fontSize: 25),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.email_outlined,
              size: 20,
            ),
            Text(
              ' agchavez@unah.hn',
              style: TextStyle(fontSize: 20),
            )
          ],
        )
      ],
    );
  }

  Widget _createedad() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Fecha de nacimiento: ',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            '25/03/1999',
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }

  Widget _createIdenty() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Numero de identidad: ',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            '1201199900497',
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }

  Widget _createSuport() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Organizar un evento',
                style: TextStyle(fontSize: 20),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios_outlined),
                onPressed: () {},
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sobre nosotros',
                style: TextStyle(fontSize: 20),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios_outlined),
                onPressed: () {},
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _createPart() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '<Nombre de la carrera>',
                style: TextStyle(fontSize: 20),
              ),
              IconButton(
                icon: IconButton(
                  icon: Icon(Icons.arrow_forward_ios_outlined),
                  onPressed: () {},
                ),
                onPressed: () {},
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _createFooter(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            PreferenciasUsuario().credentialClear();
            Navigator.pushReplacementNamed(context, 'welcome');
          },
          child: Text(
            'Cerrar sesion',
            style: TextStyle(color: Colors.red, fontSize: 20),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Text('RunXaTruch v0.1')
      ],
    );
  }
}
