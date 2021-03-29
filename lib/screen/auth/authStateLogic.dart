import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wellbeeing/screen/auth/loginPage.dart';
import 'package:wellbeeing/screen/home.dart';

class AuthStateLogic extends StatefulWidget {
  @override
  _AuthStateLogicState createState() => _AuthStateLogicState();
}

class _AuthStateLogicState extends State<AuthStateLogic> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, userSnapshot) {
        //TODO loading screen
        // if (userSnapshot.connectionState == ConnectionState.waiting) {
        //   return LoadingScreen();
        // }
        if (userSnapshot.hasData) {
          return Home();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
