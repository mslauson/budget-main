import 'dart:async';

import 'package:firebase_admin/firebase_admin.dart';
import 'package:firebase_admin/src/credential.dart';
import 'package:main/constants/iamConstants.dart';

class FirebaseAdminService {
  var _credential = Credentials.applicationDefault();

  Future<void> updatePhone(String uid, String phone) async {
    await _initializeFirebaseAdmin()
        .then((app) => app.auth().updateUser(uid, phoneNumber: phone));
  }

  Future<App> _initializeFirebaseAdmin() async {
    // when no credentials found, login using openid
    // the credentials are stored on disk for later use
    _credential ??= await Credentials.login();
    return FirebaseAdmin.instance.initializeApp(AppOptions(
        credential: _credential ?? Credentials.applicationDefault(),
        projectId: IAMConstants.FIREBASE_PROJECT));
  }
}
