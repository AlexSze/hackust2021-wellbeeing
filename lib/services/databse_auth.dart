import 'package:firebase_auth/firebase_auth.dart';

class DataBaseAuth {
  //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //SignIn
  Future signIn(AuthCredential authCreds) async {
      await FirebaseAuth.instance.signInWithCredential(authCreds).catchError((e) {});
  }

  Future signInWithOTP(smsCode, verId) async {
    AuthCredential authCreds =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    signIn(authCreds);
  }
}
