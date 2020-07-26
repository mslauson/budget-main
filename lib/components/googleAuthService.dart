import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:main/models/global/activeUser.dart';
import 'package:main/models/iam/signUpForm.dart';
import 'package:main/service/authenticationService.dart';
import 'package:main/service/registrationService.dart';
import 'package:main/ui/secureHome/secureHome.dart';
import 'package:main/ui/util/phoneNumberAlert.dart' as phoneNumberAlert;
import 'package:scoped_model/scoped_model.dart';

class GoogleAuthService {
  RegistrationService _registrationService = new RegistrationService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> attemptAuth(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final List<String> signInMethods = await _auth.fetchSignInMethodsForEmail(
        email: googleSignInAccount.email);
    if (signInMethods.isEmpty) {
      FirebaseUser firebaseUser = await _authenticate(credential, context);
      await _createUser(context, googleSignInAccount, firebaseUser);
    } else {
      await _authenticate(credential, context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => new SecureHome()),
      );
    }
  }

  SignUpForm _buildSignUpForm(
      GoogleSignInAccount googleSignInAccount, String phoneNumber) {
    if (googleSignInAccount.displayName.indexOf(" ") > 0) {
      List<String> names = googleSignInAccount.displayName.split(" ");
      return new SignUpForm(
          firstName: names[0],
          lastName: names[1],
          emailAddress: googleSignInAccount.email,
          phone: phoneNumber);
    } else {
      return new SignUpForm(
          firstName: googleSignInAccount.displayName,
          emailAddress: googleSignInAccount.email,
          phone: phoneNumber);
    }
  }

  Future<String> _getPhoneNumber(BuildContext context) async {
    return phoneNumberAlert.PhoneNumberAlert.getPhoneNumber(context);
  }

  Future<void> _createUser(
      BuildContext context,
      GoogleSignInAccount googleSignInAccount,
      FirebaseUser firebaseUser) async {
    final AuthenticationService authService = AuthenticationService();
    _getPhoneNumber(context).then((phoneNumber) => {
          _registrationService
              .addCustomer(_buildSignUpForm(googleSignInAccount, phoneNumber)),
          authService.otpCredentials(firebaseUser, phoneNumber, context)
        });
  }

  Future<FirebaseUser> _authenticate(AuthCredential credential,
      BuildContext context) async {
    final AuthResult authResult = await _auth.signInWithCredential(credential);
    ScopedModel
        .of<ActiveUser>(context, rebuildOnChange: true)
        .phone =
        authResult.user.phoneNumber;
    ScopedModel
        .of<ActiveUser>(context, rebuildOnChange: true)
        .lastLogin =
        authResult.user.metadata.lastSignInTime.toIso8601String();
    return authResult.user;
  }
}
