import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:main/constants/customerMicroserviceConstants.dart';
import 'package:main/constants/error_constants.dart';
import 'package:main/constants/iam_constants.dart';
import 'package:main/error/error_handler.dart';
import 'package:main/models/iam/signUpForm.dart';
import 'package:main/security/blossom_encryption_utility.dart';
import 'package:main/util/model_encryption_utility.dart';
import 'package:main/util/uri_builder.dart';

class CustomerClient {
  final _modelEncryption = ModelEncryptionUtility();
  final _encryptionUtility = BlossomEncryptionUtility();

  Future<String> addCustomer(SignUpForm signUpForm) async {
    signUpForm = _modelEncryption.encryptSignUpForm(signUpForm);
    var uri = UriBuilder.blossomDev(
        CustomerMicroserviceConstants.ENDPOINT_V1_CUSTOMERS, 1);
    log(uri);
    Map<String, String> headers = {"Content-type": "application/json"};

    String body = jsonEncode(signUpForm);
    var response = await post(uri, headers: headers, body: body);
    if (response.statusCode != 200) {
      ErrorHandler.onErrorClient(response, ErrorConstants.REGISTRATION);
    }
    return response.body;
  }

  Future<bool> checkPhone(String phone) async {
    String encryptedPhone = _encryptionUtility.encrypt(phone);
    encryptedPhone = Uri.encodeComponent(encryptedPhone);
    var uri = UriBuilder.blossomDevWithUri(
        CustomerMicroserviceConstants.ENDPOINT_V1_CUSTOMERS,
        1,
        CustomerMicroserviceConstants.ENDPOINT_SUFFIX_VALIDATE_PHONE);
    uri = uri + "?phone=" + encryptedPhone;
    log(uri);
    Map<String, String> headers = {"Content-type": "application/json"};

    var response = await get(
      uri,
      headers: headers,
    );
    if (response.statusCode != 200) {
      ErrorHandler.onErrorClient(response, ErrorConstants.PHONE_VERIFICATION);
    }
    var booleanResponse = jsonDecode(response.body);
    return booleanResponse[IAMConstants.USERNAME_TAKEN_KEY];
  }
}
