import 'package:flutter/material.dart';
import 'package:wellbeeing/services/databse_auth.dart';
import 'package:wellbeeing/services/noiseDetectService.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          NoiseDetectView(),
          RaisedButton(
            child: Text('Signout'),
            onPressed: () {
              DataBaseAuth().signOut();
            },
          ),
        ],
      ),
    ));
  }
}
