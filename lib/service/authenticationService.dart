import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main/models/global/activeUser.dart';
import 'package:main/models/iam/authenticationModel.dart';
import 'package:main/ui/secureHome/secureHome.dart';
import 'package:scoped_model/scoped_model.dart';

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
          _signInWithCredentials(authCredential, context);
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
    AuthCredential credentials = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: smsCode);
    _signInWithCredentials(credentials, context);
  }

  void _navigateToHomeScreen(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => SecureHome()
    ));
  }

  void _buildScopedModel(AuthResult authResult, BuildContext context) {
    ScopedModel
        .of<ActiveUser>(context, rebuildOnChange: true)
        .email = authResult.user.email;
    ScopedModel
        .of<ActiveUser>(context, rebuildOnChange: true)
        .lastLogin = authResult.user.metadata.lastSignInTime.toIso8601String();
  }

  void _signInWithCredentials(AuthCredential credentials,
      BuildContext context) {
    _auth.signInWithCredential(credentials).then((AuthResult result) {
      _buildScopedModel(result, context);
      _navigateToHomeScreen(context);
    }).catchError((e) {
      print(e);
    });
  }
}

