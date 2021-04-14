import 'dart:async';
import 'dart:math';
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
    return CustomPaint(
      child: ClipOval(
        child: Stack(
          children: [
            Image.asset(
              'assets/Well-BEEing_icon_round_1024.png',
              semanticLabel: 'noise detector',
              color: !_isRecording ? Colors.grey : null,
              colorBlendMode: BlendMode.saturation,
            ),

            // slash effect for tapping
            Positioned.fill(
                child: new Material(
                    color: Colors.transparent,
                    child: new InkWell(
                      splashColor: !_isRecording
                          ? Theme.of(context).accentColor
                          : Colors.grey,
                      onTap: () async {
                        if (!_isRecording) {
                          await start();
                        } else {
                          await stop();
                        }
                      },
                    ))),
          ],
        ),
      ),
      foregroundPainter: CircleLinePainter(
          strokeColor: _isRecording && isAbnormal ? Colors.red : Colors.white),
      painter:
          _isRecording ? CircleBackgroundPainter(noiseVal: noiseValue) : null,
    );
  }
}

// white / red circle outline inside icon
class CircleLinePainter extends CustomPainter {
  final Color strokeColor;
  CircleLinePainter({this.strokeColor});

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.shortestSide * 0.03;

    canvas.drawCircle(Offset(size.width / 2, size.height / 2),
        size.shortestSide * 0.45, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

// splash effect for noise
class CircleBackgroundPainter extends CustomPainter {
  final double noiseVal;
  CircleBackgroundPainter({this.noiseVal});

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    double factor = log(noiseVal / 90 + 1);
    const double maxRadius = 1.3; // 1: child's circle
    print('factor: $factor');

    canvas.drawCircle(Offset(size.width / 2, size.height / 2),
        size.shortestSide * maxRadius * factor, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
