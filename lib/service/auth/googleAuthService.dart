import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:main/models/iam/signUpForm.dart';
import 'package:main/screens/collectPhoneNumber.dart';
import 'package:main/service/auth/registrationService.dart';

class GoogleAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final RegistrationService _registrationService = RegistrationService();
  GoogleSignInAccount _googleSignInAccount;

  Future<void> attemptAuth(
      BuildContext context,
      final Function(AuthCredential credential, SignUpForm signUpForm)
          onCreated) async {
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
      _getPhoneNumber(credential, context);
    } else {
      onCreated(credential, null);
    }
  }

  void _getPhoneNumber(AuthCredential credential, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              CollectPhoneNumber(
                onSubmitted: (String val) {
                  String phone = val.trim();
                  List<String> name = _getName();
                  final SignUpForm signUpForm = _registrationService
                      .buildSignUpForm(
                      name[0], name[1], phone, _googleSignInAccount.email);
                  onCreated(credential, signUpForm);
                },
              )),
    );
  }

  List<String> _getName() {
    if (_googleSignInAccount.displayName.indexOf(" ") > 0) {
      return _googleSignInAccount.displayName.split(" ");
    }
    return [_googleSignInAccount.displayName, "XXXXXXXX"];
  }

}
