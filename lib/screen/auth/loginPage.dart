import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wellbeeing/services/databse_auth.dart';
import 'package:wellbeeing/widgets/buttons/submitButton.dart';
import 'package:wellbeeing/widgets/input/textBubble.dart';
import 'package:wellbeeing/widgets/sizeConfig.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();
  String phoneNo, verificationId, smsCode;
  bool codeSent = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double defaultSize = SizeConfig.defaultSize;
    var _isLoading = false;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _isLoading
          ? null
          : SubmitButton(
              defaultSize,
              _isLoading,
              codeSent ? 'Login' : 'Verify',
              () async {
                _isLoading = true;
                codeSent
                    ? await DataBaseAuth()
                        .signInWithOTP(smsCode, verificationId)
                    : await verifyPhone(phoneNo);
                _isLoading = false;
              },
            ),
      body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: defaultSize * 13),
                Image.asset(
                  'assets/Well-BEEing_icon_64.png',
                  height: 44.0,
                  width: 44.0,
                ),
                Text(
                  'Login',
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(height: defaultSize * 13),
                Text('Please enter your phone number'),
                SizedBox(height: 20.0),
                TextBubble(
                  1,
                  '',
                  '1234 8888',
                  (value) {
                    if (value.length < 8) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                  (val) {
                    setState(() {
                      this.phoneNo = '+852' + val;
                    });
                  },
                  false,
                ),
                SizedBox(height: 50.0),
                codeSent ? Text('Please enter the OTP code') : Container(),
                SizedBox(height: 20.0),
                codeSent
                    ? TextBubble(
                        1,
                        '',
                        '123456',
                        (value) {
                          return null;
                        },
                        (val) {
                          setState(() {
                            this.smsCode = val;
                          });
                        },
                        false,
                      )
                    : Container(),
              ],
            ),
          )),
    );
  }

  Future<void> verifyPhone(phoneNo) async {
    print(phoneNo);
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      DataBaseAuth().signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (FirebaseAuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNo,
      timeout: const Duration(seconds: 5),
      verificationCompleted: verified,
      verificationFailed: verificationfailed,
      codeSent: smsSent,
      codeAutoRetrievalTimeout: autoTimeout,
    );
  }
}
