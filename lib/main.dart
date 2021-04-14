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
      ),
      home: AuthStateLogic(),
    );
  }
}
