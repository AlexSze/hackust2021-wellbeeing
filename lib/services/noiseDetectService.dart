import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:noise_meter/noise_meter.dart';

class NoiseDetectView extends StatefulWidget {
  @override
  _NoiseDetectViewState createState() => _NoiseDetectViewState();
}

class _NoiseDetectViewState extends State<NoiseDetectView> {
  bool isRecording = false;
  double noiseValue = -1;
  bool hasPermission = false;
  bool _isRecording = false;
  StreamSubscription<NoiseReading> _noiseSubscription;
  NoiseMeter _noiseMeter;

  void _onData(NoiseReading noiseReading) {
    if (!this._isRecording) {
      this._isRecording = true;
    }
    onData(noiseReading.meanDecibel);
    print(noiseReading.toString());
  }

  void _onError(PlatformException e) {
    print(e.toString());
    _isRecording = false;
  }

  Future start() async {
    try {
      print('start');
      await getPermission();
      _noiseSubscription = _noiseMeter.noiseStream.listen(_onData);
    } catch (err) {
      print(err);
    }
  }

  Future stop() async {
    try {
      if (_noiseSubscription != null) {
        _noiseSubscription.cancel();
        _noiseSubscription = null;
      }
      setState(() {
        _isRecording = false;
      });
    } catch (err) {
      print('stopRecorder error: $err');
    }
  }

  Future getPermission() async {
    print('get permission');
    var permission = Permission.microphone; // can be array of permission
    print('getting permission...');
    if (await permission.request().isGranted) {
      print('permission granted!');
      setState(() {
        hasPermission = true;
      });
    } else {
      print('permission denied!');
      setState(() {
        hasPermission = false;
      });
    }
  }

  onData(double val) {
    setState(() {
      noiseValue = val;
    });
  }

  bool get isAbnormal {
    return noiseValue >= 90;
  }

  @override
  void initState() {
    super.initState();
    _noiseMeter = new NoiseMeter(_onError);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _isRecording
              ? 'Abnormality: ${noiseValue.toStringAsFixed(1)}'
              : 'None',
          style: TextStyle(
              color: !_isRecording || isAbnormal ? Colors.red : Colors.green,
              fontSize: 30),
        ),
        FlatButton(
          onPressed: () async {
            if (!_isRecording) {
              await start();
            } else {
              await stop();
            }
          },
          child: Text(_isRecording ? 'Detecting...' : 'Start Detection'),
          color: _isRecording ? Colors.green : Colors.red,
        )
      ],
    );
  }
}
