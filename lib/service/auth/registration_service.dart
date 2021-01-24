import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:main/client/customer_client.dart';
import 'package:main/models/iam/signUpForm.dart';
import 'package:main/models/valueModel.dart';

class RegistrationService {
  final _auth = FirebaseAuth.instance;

  @Deprecated("In favor of OTP")
  Future<bool> registerToFirebase(
      SignUpForm signUpForm, ValueModel valueModel) async {
    final UserCredential authResult = await _auth.createUserWithEmailAndPassword(
      email: signUpForm.emailAddress,
      password: valueModel.value,
    );
    log(authResult.additionalUserInfo.username +
        " has been registered successfully");
    await addCustomer(signUpForm);
    return true;
  }

  Future<void> addCustomer(SignUpForm signUpForm) async {
    CustomerClient customerClient = new CustomerClient();
    String customerResponse = await customerClient.addCustomer(signUpForm);
    log(customerResponse.toString());
  }

  Future<bool> checkIfUserExists(String phone) async {
    final CustomerClient _customerClient = CustomerClient();
    return await _customerClient.checkPhone(phone);
  }

  SignUpForm buildSignUpForm(
      String firstName, String lastName, String phone, String email) {
    return new SignUpForm(
        firstName: firstName,
        lastName: lastName,
        emailAddress: email,
        phone: phone);
  }
}