import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wellbeeing/screen/auth/authStateLogic.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wellbeeing',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        accentColor: Colors.blue,
        primaryColorLight: Color(0xFFFEF7F8),
        canvasColor: Colors.white,
        dialogBackgroundColor: Colors.grey,
        hintColor: Color.fromRGBO(172, 172, 172, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline1: TextStyle(
                color: Color.fromRGBO(17, 17, 17, 1), //30
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
              subtitle1: TextStyle(
                color: Color.fromRGBO(134, 142, 150, 1), //30
                fontWeight: FontWeight.normal,
                fontSize: 17,
              ),
              bodyText1: TextStyle(
                color: Color.fromRGBO(17, 17, 17, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(134, 142, 150, 1),
              ),
            ),
      ),
      home: AuthStateLogic(),
    );
  }
}
