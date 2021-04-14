import 'package:flutter/material.dart';
import 'package:wellbeeing/services/databse_auth.dart';
import 'package:wellbeeing/services/noiseDetectService.dart';
import 'package:wellbeeing/widgets/buttons/submitButton.dart';
import 'package:wellbeeing/widgets/sizeConfig.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double defaultSize = SizeConfig.defaultSize;
    var _isLoading = false;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SubmitButton(
        defaultSize,
        _isLoading,
        'Sign Out',
        () async {
          DataBaseAuth().signOut();
        },
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NoiseDetectView(),
            ],
          ),
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
