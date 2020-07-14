import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main/models/iam/authenticationModel.dart';
import 'package:main/ui/secureHome/secureHome.dart';

class AuthenticationService {
  String smsOTP;
  String verificationId;
  String errorMessage = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _smsCodeController = TextEditingController();

  Future<void> authenticateUser(AuthenticationModel authenticationModel,
      BuildContext context) async {
    await _authenticateFirebase(authenticationModel, context);
  }

  _authenticateFirebase(AuthenticationModel authenticationModel,
      BuildContext context) async {
    _auth.verifyPhoneNumber(
        phoneNumber: authenticationModel.phoneNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential authCredential) {
          _auth.signInWithCredential(authCredential).then((AuthResult result) {
            _navigateToHomeScreen(context);
          }).catchError((e) {
            print(e);
          });
        },
        verificationFailed: (AuthException authException) {
          print(authException.message);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          _showDialog(context);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
          print(verificationId);
          print("OTP Auto Retrieval failed");
        }
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) =>
            AlertDialog(
              title: Text("Enter SMS Code"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: _smsCodeController,
                  ),

                ],
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("Done"),
                  textColor: Colors.white,
                  color: Colors.redAccent,
                  onPressed: () {
                    _acceptDialog(context);
                  },
                )
              ],
            )
    );
  }

  void _acceptDialog(BuildContext context){
    String smsCode = _smsCodeController.text.trim();

    AuthCredential credentials = PhoneAuthProvider
        .getCredential(
        verificationId: verificationId, smsCode: smsCode);
    _auth.signInWithCredential(credentials).then((
        AuthResult result) {
     _navigateToHomeScreen(context);
    }).catchError((e) {
      print(e);
    });
  }

  void _navigateToHomeScreen(BuildContext context){
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => SecureHome()
    ));
  }
}

