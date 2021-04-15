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
  String _errorMessage = '';

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
                setState(() {
                  _errorMessage = '';
                });
                try {
                  if (formKey.currentState.validate()) {
                    if (codeSent) {
                      await DataBaseAuth()
                          .signInWithOTP(smsCode, verificationId);
                    } else {
                      verifyPhone(phoneNo);
                    }
                  }
                } on FirebaseAuthException catch (e) {
                  print('Failed with error code: ${e.code}');
                  print(e.message);
                  setState(() {
                    _errorMessage = e.message;
                  });
                } catch (e) {
                  setState(() {
                    _errorMessage = e.toString();
                  });
                }

                _isLoading = false;
              },
            ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: defaultSize * 13),
                  Image.asset(
                    'assets/Well-BEEing_icon_round_1024.png',
                    height: 44.0,
                    width: 44.0,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Silver-Age',
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 32,
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: defaultSize * 7),
                  Text(
                    'Please enter your phone number',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(height: 20.0),
                  TextBubble(
                    1,
                    '',
                    '8888 8888',
                    (String value) {
                      if (value.length != 8) {
                        return 'Please enter a valid phone number';
                      }
                      return null;
                    },
                    (String val) {
                      setState(() {
                        this.phoneNo = '+852' + val;
                      });
                    },
                    false,
                    prefix: true,
                    textInputType: TextInputType.phone,
                    allowCharacters: '[0-9]',
                  ),
                  SizedBox(height: 50.0),
                  codeSent
                      ? Text(
                          'Please enter the OTP code',
                          style: Theme.of(context).textTheme.bodyText1,
                        )
                      : Container(),
                  SizedBox(height: 20.0),
                  codeSent
                      ? TextBubble(
                          1,
                          '',
                          '123456',
                          (String value) {
                            if (value.length != 6) {
                              return 'Please enter a valid OTP code';
                            }
                            return null;
                          },
                          (val) {
                            setState(() {
                              this.smsCode = val;
                            });
                          },
                          true,
                          textInputType: TextInputType.number,
                          allowCharacters: '[0-9]',
                        )
                      : Container(),
                  SizedBox(height: defaultSize * 13),
                  Text(_errorMessage,
                      style: TextStyle(color: Theme.of(context).errorColor)),
                ],
              ),
            )),
      ),
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
