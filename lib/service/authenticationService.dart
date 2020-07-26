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
  AuthCredential authCredential;

  void authenticateUser(String phone, BuildContext context) {
    _authenticateOtp(phone, context);
    _signInWithCredentials(authCredential, context);
  }

  AuthCredential otpCredentials(String phoneNumber, BuildContext context) {
    _authenticateOtp(phoneNumber, context);
    return authCredential;
  }

  void _authenticateOtp(String phoneNumber, BuildContext context) {
    _auth.verifyPhoneNumber(
        phoneNumber: "+1" + phoneNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential authCredential) {
          authCredential = authCredential;
        },
        verificationFailed: (AuthException authException) {
          print(authException.message);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          _verificationId = verificationId;
          _showDialogOtp(context);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
          print(verificationId);
          print("OTP Auto Retrieval failed");
        }
    );
  }

  void _showDialogOtp(BuildContext context) {
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
    authCredential = PhoneAuthProvider.getCredential(
        verificationId: _verificationId, smsCode: smsCode);
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
}

