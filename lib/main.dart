import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:runxatruch_app/bloc/mapa/mapa_bloc.dart';
import 'package:runxatruch_app/pages/account_pages.dart';
import 'package:runxatruch_app/pages/event_page.dart';
import 'package:runxatruch_app/pages/example.dart';
import 'package:runxatruch_app/pages/historial_training.dart';
import 'package:runxatruch_app/pages/home_pages.dart';
import 'package:runxatruch_app/pages/login_pages.dart';
import 'package:runxatruch_app/pages/map_page.dart';
import 'package:runxatruch_app/pages/participations_pages.dart';
import 'package:runxatruch_app/pages/recover_pages.dart';

import 'package:runxatruch_app/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:runxatruch_app/pages/setting_porfile.dart';
import 'package:runxatruch_app/pages/welcome_pages.dart';
import 'package:runxatruch_app/prefUser/preferent_user.dart';

//import 'package:runxatruch_app/pages/sign_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _pref = PreferenciasUsuario();
    if (_pref.credential == "") {
      return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => MiUbicacionBloc(),
            ),
            BlocProvider(
              create: (_) => MapaBloc(),
            )
          ],
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: [
                const Locale('en', 'US'), // English
                const Locale('es', 'ES'),
              ],
              title: 'Material App',
              home: Scaffold(
                appBar: AppBar(
                  title: Text('Material App Bar'),
                ),
              ),
              initialRoute: 'welcome',
              routes: {
                'welcome': (BuildContext context) => WelcomePages(),
                'login': (BuildContext context) => LoginPages(),
                'home': (BuildContext context) => HomePage(),
                'recoverAccount': (BuildContext context) => RecoverAccount(),
                'createAccount': (BuildContext context) => CreateAccount(),
                'setting': (BuildContext context) => SettingPage(),
                'map': (BuildContext context) => MapPage(),
                'historial': (BuildContext context) => HistorialTraining(),
                'participation': (BuildContext context) => ParticipationsPage(),
                'event': (BuildContext context) => EventPages()
                //'example': (BuildContext context) => Example()
              },
              theme: ThemeData(
                // Define the default brightness and colors.
                brightness: Brightness.light,
                primaryColor: Colors.red[400], //red[400],
                accentColor: Colors.red[400], //red[400],

                // Define the default TextTheme. Use this to specify the default
                // text styling for headlines, titles, bodies of text, and more.
              )));
    } else {
      final data = jsonDecode(_pref.credential);
      final initialapp = data['mantener'] ? 'home' : 'welcome';
      return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => MiUbicacionBloc(),
            ),
            BlocProvider(
              create: (_) => MapaBloc(),
            )
          ],
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: [
                const Locale('en', 'US'), // English
                const Locale('es', 'ES'),
              ],
              title: 'Material App',
              home: Scaffold(
                appBar: AppBar(
                  title: Text('Material App Bar'),
                ),
              ),
              initialRoute: initialapp,
              routes: {
                'welcome': (BuildContext context) => WelcomePages(),
                'login': (BuildContext context) => LoginPages(),
                'home': (BuildContext context) => HomePage(),
                'recoverAccount': (BuildContext context) => RecoverAccount(),
                'createAccount': (BuildContext context) => CreateAccount(),
                'setting': (BuildContext context) => SettingPage(),
                'map': (BuildContext context) => MapPage(),
                'historial': (BuildContext context) => HistorialTraining(),
                'participation': (BuildContext context) => ParticipationsPage(),
                'event': (BuildContext context) => EventPages()
                //'example': (BuildContext context) => Example()
              },
              theme: ThemeData(
                // Define the default brightness and colors.
                brightness: Brightness.light,
                primaryColor: Colors.red[400], //red[400],
                accentColor: Colors.red[400], //red[400],

                // Define the default TextTheme. Use this to specify the default
                // text styling for headlines, titles, bodies of text, and more.
              )));
    }
  }
}
