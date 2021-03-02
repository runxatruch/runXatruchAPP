import 'package:flutter/material.dart';
import 'package:runxatruch_app/prefUser/preferent_user.dart';
import 'package:runxatruch_app/provider/user_provider.dart';
import 'package:runxatruch_app/models/user_models.dart';

class PorfilePage extends StatelessWidget {
  const PorfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pro = UserProvider();

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
      body: Center(
        child: FutureBuilder(
          future: pro.getDataUser(),
          builder:
              (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data;
              return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: data.length,
                  itemBuilder: (context, i) {
                    return Column(
                      children: <Widget>[
                        Container(
                          height: size.height * 0.40,
                          child: _createPorfile(data[i], context),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text('Datos Personales', textAlign: TextAlign.end),
                        Divider(),
                        _createedad(data[i]),
                        SizedBox(
                          height: 10,
                        ),
                        _createIdenty(data[i]),
                        SizedBox(
                          height: 40,
                        ),
                        Text('Participaciones', textAlign: TextAlign.start),
                        Divider(),
                        _createPart(data[i], context),
                        SizedBox(
                          height: 40,
                        ),
                        Text('Soporte', textAlign: TextAlign.start),
                        Divider(),
                        _createSuport(),
                        SizedBox(
                          height: 20,
                        ),
                        _createFooter(context)
                      ],
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget _createPorfile(UserModel data, context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/unnamed.png',
          height: size.height * 0.22,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          '${data.nombres} ${data.apellidos}',
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
              '${data.email}',
              style: TextStyle(fontSize: 20),
            )
          ],
        )
      ],
    );
  }

  Widget _createedad(UserModel data) {
    final date = DateTime.parse(data.fechaNac);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Fecha de nacimiento: ',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            '${date.day}/${date.month}/${date.year}',
            style: TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }

  Widget _createIdenty(UserModel data) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Numero de identidad: ',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            '${data.identidad}',
            style: TextStyle(fontSize: 18),
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
                style: TextStyle(fontSize: 18),
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
                style: TextStyle(fontSize: 18),
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

  Widget _createPart(UserModel data, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ir a mis participaciones',
                style: TextStyle(fontSize: 18),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios_outlined),
                onPressed: () => Navigator.pushNamed(context, 'participation',
                    arguments: data.participations),
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
