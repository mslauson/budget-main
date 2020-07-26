import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:main/service/authenticationService.dart';

class FirebaseAdminService {
  Future<void> updatePhone(
      FirebaseUser firebaseUser, String phone, BuildContext context) async {
    AuthenticationService authenticationService = new AuthenticationService();
    AuthCredential authCredential =
        await authenticationService.otpCredentials(phone, context);
    await firebaseUser.updatePhoneNumberCredential(authCredential);
  }
}
