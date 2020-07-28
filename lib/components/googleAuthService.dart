import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:main/service/authenticationService.dart';
import 'package:main/ui/util/phoneNumberAlert.dart' as phoneNumberAlert;

class GoogleAuthService {
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
    String phone = await _getPhoneNumber(context);
    if (signInMethods.isEmpty) {
      _authService.signInWithCredentials(credential, phone, context);
    } else {
      _authService.signInWithCredentials(credential, null, context);
    }
  }

  Future<String> _getPhoneNumber(BuildContext context) async {
    return phoneNumberAlert.PhoneNumberAlert.getPhoneNumber(context);
  }
}
