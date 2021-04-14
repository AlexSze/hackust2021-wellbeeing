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
      debugShowCheckedModeBanner: false,
      title: 'Wellbeeing',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        accentColor: Color.fromRGBO(246, 137, 17, 1),
        primaryColorLight: Color.fromRGBO(243, 113, 1, 1),
        canvasColor: Colors.white,
        dialogBackgroundColor: Color.fromRGBO(250, 250, 250, 1),
        hintColor: Color.fromRGBO(172, 172, 172, 1),
        backgroundColor: Color.fromRGBO(250, 247, 235, 1),
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
