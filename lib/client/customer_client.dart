import 'dart:convert';

import 'package:http/http.dart';
import 'package:main/constants/customerMicroserviceConstants.dart';
import 'package:main/constants/error_constants.dart';
import 'package:main/constants/iam_constants.dart';
import 'package:main/error/error_handler.dart';
import 'package:main/models/iam/signUpForm.dart';
import 'package:main/security/blossom_encryption_utility.dart';
import 'package:main/util/model_encryption_utility.dart';

class CustomerClient {
  final _modelEncryption = ModelEncryptionUtility();
  final _encryptionUtility = BlossomEncryptionUtility();

  Future<String> addCustomer(SignUpForm signUpForm) async {
    signUpForm = _modelEncryption.encryptSignUpForm(signUpForm);
    var uri = Uri.http(CustomerMicroserviceConstants.BASE_URL_CUSTOMERS,
        CustomerMicroserviceConstants.ENDPOINT_V1_CUSTOMERS);
    Map<String, String> headers = {"Content-type": "application/json"};

    var response =
        await post(uri, headers: headers, body: jsonEncode(signUpForm));
    if (response.statusCode != 200) {
      ErrorHandler.onErrorClient(response, ErrorConstants.REGISTRATION);
    }
    return response.body;
  }

  Future<bool> checkPhone(String phone) async {
    phone = _encryptionUtility.encrypt(phone);
    String path = CustomerMicroserviceConstants.ENDPOINT_V1_CUSTOMERS +
        CustomerMicroserviceConstants.ENDPOINT_SUFFIX_VALIDATE +
        CustomerMicroserviceConstants.ENDPOINT_SUFFIX_PHONE +
        phone;
    var uri = Uri.http(CustomerMicroserviceConstants.BASE_URL_CUSTOMERS, path);
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
