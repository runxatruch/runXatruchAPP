import 'package:flutter/material.dart';
import 'package:runxatruch_app/pages/account_pages.dart';
import 'package:runxatruch_app/pages/home_pages.dart';
import 'package:runxatruch_app/pages/login_pages.dart';
import 'package:runxatruch_app/pages/recover_pages.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
      ),
      initialRoute: 'login',
      routes: {
        'login': (BuildContext context) => LoginPages(),
        'home': (BuildContext context) => HomePages(),
        'recoverAccount': (BuildContext context) => RecoverAccount(),
        'createAccount': (BuildContext context) => CreateAccount(),
     
     
      },
  
    );
  }
}
