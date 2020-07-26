import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main/client/customerClient.dart';
import 'package:main/models/global/activeUser.dart';
import 'package:main/screens/newUserFullName.dart';
import 'package:main/ui/secureHome/secureHome.dart';
import 'package:scoped_model/scoped_model.dart';

class AuthenticationService {
  String _verificationId;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _smsCodeController = TextEditingController();
  final CustomerClient _customerClient = new CustomerClient();
  FirebaseUser currentUser;

  void authenticateUser(String phone, BuildContext context) {
    _authenticateOtp(phone, true, context);
  }

  void otpCredentials(
      FirebaseUser firebaseUser, String phoneNumber, BuildContext context) {
    currentUser = firebaseUser;
    _authenticateOtp(phoneNumber, false, context);
  }

  void _authenticateOtp(String phoneNumber, bool signIn, BuildContext context) {
    _auth.verifyPhoneNumber(
        phoneNumber: "+1" + phoneNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential creds) {
          if (signIn) {
            _signInWithCredentials(creds, context);
          } else {
            _linkPhone(creds, context);
          }
        },
        verificationFailed: (AuthException authException) {
          print(authException.message);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          _verificationId = verificationId;
          _showDialogOtp(context, signIn);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
          print(verificationId);
          print("OTP Auto Retrieval failed");
        });
  }

  void _showDialogOtp(BuildContext context, bool signIn) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
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
                    _acceptDialog(context, signIn);
                  },
                )
              ],
            )
    );
  }

  void _acceptDialog(BuildContext context, bool signIn) {
    String smsCode = _smsCodeController.text.trim();
    AuthCredential authCredential = PhoneAuthProvider.getCredential(
        verificationId: _verificationId, smsCode: smsCode);
    if (signIn) {
      _signInWithCredentials(authCredential, context);
    } else {
      _linkPhone(authCredential, context);
    }
  }

  void _navigateToHomeScreen(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => SecureHome()
    ));
  }

  void _buildScopedModel(AuthResult authResult, BuildContext context) {
    ScopedModel.of<ActiveUser>(context, rebuildOnChange: true).phone =
        authResult.user.phoneNumber.substring(1);
    ScopedModel.of<ActiveUser>(context, rebuildOnChange: true).lastLogin =
        authResult.user.metadata.lastSignInTime.toIso8601String();
  }

  void _signInWithCredentials(AuthCredential credentials,
      BuildContext context) {
    _auth.signInWithCredential(credentials).then((AuthResult result) {
      String phone = result.user.phoneNumber.substring(1);
      _customerClient.checkPhone(phone).then((userExists) {
        if (userExists) {
          _buildScopedModel(result, context);
          _navigateToHomeScreen(context);
        } else {
          _gatherName(phone, context);
        }
      });
    }).catchError((e) {
      print(e);
    });
  }

  void _gatherName(String phone, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewUserFullName(phone: phone)),
    );
  }

  void _linkPhone(AuthCredential credential, BuildContext context) {
    currentUser.updatePhoneNumberCredential(credential).whenComplete(() =>
        _navigateToHomeScreen(context)
    );
  }
}

