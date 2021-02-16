import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:runxatruch_app/pages/account_pages.dart';
import 'package:runxatruch_app/pages/home_pages.dart';
import 'package:runxatruch_app/pages/login_pages.dart';
import 'package:runxatruch_app/pages/recover_pages.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:runxatruch_app/pages/welcome_pages.dart';
import 'package:runxatruch_app/prefUser/preferent_user.dart';

//import 'package:runxatruch_app/pages/sign_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  final initialapp =
      PreferenciasUsuario().credential == '' ? 'welcome' : 'home';
  @override
  Widget build(BuildContext context) {
    print(PreferenciasUsuario().credential);
    return MaterialApp(
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
          'home': (BuildContext context) => HomePages(),
          'recoverAccount': (BuildContext context) => RecoverAccount(),
          'createAccount': (BuildContext context) => CreateAccount(),
        },
        theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.light,
          primaryColor: Colors.lightBlue[800],
          accentColor: Colors.cyan[600],

          // Define the default TextTheme. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
        ));
  }
}
