import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:main/models/iam/signUpForm.dart';
import 'package:main/service/authenticationService.dart';
import 'package:main/service/registrationService.dart';
import 'package:main/ui/util/phoneNumberAlert.dart' as phoneNumberAlert;

class GoogleAuthService {
  RegistrationService _registrationService = new RegistrationService();
  AuthenticationService _authService = new AuthenticationService(true);
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
      String phone = await _getPhoneNumber(context);
      await _registrationService
          .addCustomer(_buildSignUpForm(googleSignInAccount, phone));
      _authService.signInWithCredentials(credential, phone, context);
    } else {
      _authService.signInWithCredentials(credential, null, context);
    }
  }

  Future<String> _getPhoneNumber(BuildContext context) async {
    return phoneNumberAlert.PhoneNumberAlert.getPhoneNumber(context);
  }

  SignUpForm _buildSignUpForm(GoogleSignInAccount googleSignInAccount,
      String phoneNumber) {
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

}
