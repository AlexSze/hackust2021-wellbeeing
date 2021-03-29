import 'package:flutter/material.dart';
import 'package:wellbeeing/services/databse_auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: RaisedButton(
      child: Text('Signout'),
      onPressed: () {
        DataBaseAuth().signOut();
      },
    )));
  }
}
