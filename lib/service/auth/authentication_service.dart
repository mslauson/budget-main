import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main/models/global/activeUser.dart';
import 'package:main/models/iam/signUpForm.dart';
import 'package:main/screens/collect_otp.dart';
import 'package:main/screens/collect_user_info.dart';
import 'package:main/service/auth/registration_service.dart';
import 'package:main/ui/secureHome/secureHome.dart';
import 'package:scoped_model/scoped_model.dart';

import 'google_auth_service.dart';

class AuthenticationService {
  String _verificationId;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final RegistrationService _registrationService = new RegistrationService();
  GoogleAuthService _googleAuthService = GoogleAuthService();
  FirebaseUser _currentUser;
  SignUpForm _signUpForm;
  String _otpPhone;

  void authenticateUserPhone(String phone, BuildContext context) {
    _otpPhone = "1" + phone;
    _authenticateOtp(phone, context);
  }

  Future<void> authenticateGoogle(BuildContext context) async {
    _googleAuthService.attemptAuth(
        context,
        (credential, signUpForm) => {
              if (signUpForm != null)
                {signInWithCredentials(credential, signUpForm.phone, context)}
              else
                {signInWithCredentials(credential, null, context)}
            });
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
        _otpPhone = "1" + phone;
        _checkIfUserExists(result, phone, context);
      }
    }).catchError((e) {
      print(e);
    });
  }

  void _authenticateOtp(String phoneNumber, BuildContext context) {
    _auth.verifyPhoneNumber(
        phoneNumber: "+1" + phoneNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential authCredential) {
          if (_signUpForm != null) {
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
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                new CollectOtp(
                  onSubmit: (phone) => _acceptDialog(context, phone),
                )),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
          print(verificationId);
          print("OTP Auto Retrieval failed");
        });
  }

  void _acceptDialog(BuildContext context, String code) {
    AuthCredential authCredential = PhoneAuthProvider.getCredential(
        verificationId: _verificationId, smsCode: code);
    if (_signUpForm != null) {
      _linkPhone(authCredential, context);
    } else {
      signInWithCredentials(authCredential, _otpPhone, context);
    }
  }

  void _checkIfUserExists(AuthResult result, String phone,
      BuildContext context) {
    _registrationService.checkIfUserExists(phone).then((userExists) async {
      if (!userExists) {
        if (_signUpForm != null) {
          _buildScopedModel(phone,
              result.user.metadata.lastSignInTime.toIso8601String(), context);
          await _registrationService.addCustomer(_signUpForm);
          _authenticateOtp(phone, context);
        } else {
          _buildScopedModel(result.user.phoneNumber.substring(1),
              result.user.metadata.lastSignInTime.toIso8601String(),
              context
          );
          _gatherFinalInfo(phone, context);
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

  void _gatherFinalInfo(String phone, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              CollectUserInfoScreen(
                phone: phone,
                onSubmit: (SignUpForm signUpForm) async =>
                {
                  await _registrationService.addCustomer(signUpForm),
                  _linkEmail(signUpForm.emailAddress, context)
                },
              )),
    );
  }

  void _linkPhone(AuthCredential credential, BuildContext context) {
    _currentUser
        .updatePhoneNumberCredential(credential)
        .whenComplete(() => _navigateToHomeScreen(context));
  }

  Future<void> _linkEmail(String email,
      BuildContext context) async {
    await _currentUser.updateEmail(email);
    _currentUser
        .updatePassword("XXXXXXXX")
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

