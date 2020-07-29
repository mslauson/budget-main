import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:main/models/iam/signUpForm.dart';
import 'package:main/screens/collectPhoneNumber.dart';
import 'package:main/service/authenticationService.dart';

class GoogleAuthService {
  AuthenticationService _authService;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignInAccount _googleSignInAccount;

  Future<void> attemptAuth(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    _googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await _googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final List<String> signInMethods = await _auth.fetchSignInMethodsForEmail(
        email: _googleSignInAccount.email);
    if (signInMethods.isEmpty) {
      String phone = await _getPhoneNumber(context);
      _authService = new AuthenticationService(true, _buildSignUpForm(phone));
      _authService.signInWithCredentials(credential, phone, context);
    } else {
      _authService = new AuthenticationService(true, null);
      _authService.signInWithCredentials(credential, null, context);
    }
  }

  Future<String> _getPhoneNumber(BuildContext context) async {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>
          CollectPhoneNumber(onSubmitted: (String phone) {
            _buildSignUpForm(phone);
          },)),
    );
  }

  SignUpForm _buildSignUpForm(String phoneNumber) {
    if (_googleSignInAccount.displayName.indexOf(" ") > 0) {
      List<String> names = _googleSignInAccount.displayName.split(" ");
      return new SignUpForm(
          firstName: names[0],
          lastName: names[1],
          emailAddress: _googleSignInAccount.email,
          phone: phoneNumber);
    } else {
      return new SignUpForm(
          firstName: _googleSignInAccount.displayName,
          emailAddress: _googleSignInAccount.email,
          phone: phoneNumber);
    }
  }

}
