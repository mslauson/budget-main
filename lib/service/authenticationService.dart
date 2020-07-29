import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main/client/customerClient.dart';
import 'package:main/models/global/activeUser.dart';
import 'package:main/models/iam/signUpForm.dart';
import 'package:main/screens/newUserFullName.dart';
import 'package:main/service/registrationService.dart';
import 'package:main/ui/secureHome/secureHome.dart';
import 'package:scoped_model/scoped_model.dart';

class AuthenticationService {
  String _verificationId;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _smsCodeController = TextEditingController();
  final CustomerClient _customerClient = new CustomerClient();
  final RegistrationService _registrationService = new RegistrationService();
  final bool _isAuthProvider;
  final SignUpForm _signUpForm;
  FirebaseUser _currentUser;

  AuthenticationService(this._isAuthProvider, this._signUpForm);

  void authenticateUser(String phone, BuildContext context) {
    _authenticateOtp(phone, context);
  }

  void signInWithCredentials(
      AuthCredential credentials, String phone, BuildContext context) {
    _auth.signInWithCredential(credentials).then((AuthResult result) {
      _currentUser = result.user;
      if (phone == null) {
        _buildScopedModel(result.user.phoneNumber.substring(1),
            result.user.metadata.lastSignInTime.toIso8601String(), context);
        _navigateToHomeScreen(context);
      } else {
        _checkIfUserExists(result, phone.substring(1), context);
      }
    }).catchError((e) {
      print(e);
    });
  }

  void _authenticateOtp(String phoneNumber, BuildContext context) {
    _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential authCredential) {
          if (_isAuthProvider) {
            _linkPhone(authCredential, context);
          } else {
            signInWithCredentials(authCredential, phoneNumber, context);
          }
        },
        verificationFailed: (AuthException authException) {
          print(authException.message);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          _verificationId = verificationId;
          _showDialogOtp(context, phoneNumber);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
          print(verificationId);
          print("OTP Auto Retrieval failed");
        });
  }

  void _showDialogOtp(
    BuildContext context,
    String phone,
  ) async {
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
                    _acceptDialog(context, phone);
                  },
                )
              ],
            )
    );
  }

  void _acceptDialog(BuildContext context, String phone) {
    String smsCode = _smsCodeController.text.trim();
    AuthCredential authCredential = PhoneAuthProvider.getCredential(
        verificationId: _verificationId, smsCode: smsCode);
    if (_isAuthProvider) {
      _linkPhone(authCredential, context);
    } else {
      signInWithCredentials(authCredential, phone, context);
    }
  }

  void _checkIfUserExists(AuthResult result, String phone,
      BuildContext context) {
    _customerClient.checkPhone(phone).then((userExists) async {
      if (!userExists) {
        if (_isAuthProvider) {
          _buildScopedModel(phone,
              result.user.metadata.lastSignInTime.toIso8601String(), context);
          await _registrationService.addCustomer(_signUpForm);
          _authenticateOtp(phone, context);
        } else {
          _buildScopedModel(result.user.phoneNumber.substring(1),
              result.user.metadata.lastSignInTime.toIso8601String(),
              context
          );
          _gatherName(phone, context);
        }
      } else {
        _buildScopedModel(
            result.user.phoneNumber.substring(1),
            result.user.metadata.lastSignInTime.toIso8601String(),
            context
        );
        _navigateToHomeScreen(context);
      }
    });
  }

  void _gatherName(String phone, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewUserFullName(phone: phone)),
    );
  }

  void _linkPhone(AuthCredential credential, BuildContext context) {
    _currentUser
        .updatePhoneNumberCredential(credential)
        .whenComplete(() => _navigateToHomeScreen(context));
  }

  void _navigateToHomeScreen(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SecureHome()));
  }

  void _buildScopedModel(String phone, String lastSignIn,
      BuildContext context) {
    ScopedModel
        .of<ActiveUser>(context, rebuildOnChange: true)
        .phone =
        phone;
    ScopedModel
        .of<ActiveUser>(context, rebuildOnChange: true)
        .lastLogin =
        lastSignIn;
  }
}

