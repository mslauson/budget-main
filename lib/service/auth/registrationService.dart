import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:main/client/customerClient.dart';
import 'package:main/models/iam/signUpForm.dart';
import 'package:main/models/valueModel.dart';

class RegistrationService {
  final _auth = FirebaseAuth.instance;

  @Deprecated("In favor of OTP")
  Future<bool> registerToFirebase(
      SignUpForm signUpForm, ValueModel valueModel) async {
    final AuthResult authResult = await _auth.createUserWithEmailAndPassword(
      email: signUpForm.emailAddress,
      password: valueModel.value,
    );
    log(authResult.additionalUserInfo.username +
        " has been registered successfully");
    await addCustomer(signUpForm);
    return true;
  }
   Future<void> addCustomer( SignUpForm signUpForm) async {
     CustomerClient customerClient = new CustomerClient();
     String customerResponse =
     await customerClient.addCustomer(jsonEncode(signUpForm.toJson()));
     log(customerResponse.toString());

   }
}