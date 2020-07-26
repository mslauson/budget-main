import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:main/service/authenticationService.dart';

class FirebaseAdminService {
  void updatePhone(
      FirebaseUser firebaseUser, String phone, BuildContext context) {
    AuthenticationService authenticationService = new AuthenticationService();
    AuthCredential authCredential =
        authenticationService.otpCredentials(phone, context);
    firebaseUser.updatePhoneNumberCredential(authCredential);
  }
}
