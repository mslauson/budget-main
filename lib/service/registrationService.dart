import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:main/client/customerClient.dart';
import 'package:main/models/iam/signUpForm.dart';
import 'package:main/models/valueModel.dart';

class RegistrationService {
  Future<bool> addCustomer(bool validForm, SignUpForm signUpForm,
      ValueModel valueModel) async {
    final _auth = FirebaseAuth.instance;
    if (validForm) {
      CustomerClient customerClient = new CustomerClient();
      String customerResponse =
      await customerClient.addCustomer(jsonEncode(signUpForm.toJson()));
      log(customerResponse.toString());
      final AuthResult authResult = await _auth.createUserWithEmailAndPassword(
        email: signUpForm.emailAddress,
        password: valueModel.value,
      );
      _auth.c
      log(authResult.additionalUserInfo.username +
          " has been registered successfully");
      return true;
    }
    return false;
  }
}