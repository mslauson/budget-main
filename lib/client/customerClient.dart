import 'dart:convert';

import 'package:http/http.dart';
import 'package:main/constants/customerMicroserviceConstants.dart';
import 'package:main/constants/iamConstants.dart';
import 'package:main/error/errorHandler.dart';

class CustomerClient {
  Future<String> addCustomer(String payload) async {
    String url = CustomerMicroserviceConstants.BASE_URL_CUSTOMERS +
        CustomerMicroserviceConstants.ENDPOINT_V1_CUSTOMERS;
    Map<String, String> headers = {"Content-type": "application/json"};
//
    var response = await post(url, headers: headers, body: payload);
    if (response.statusCode != 200) {
      ErrorHandler.onError(response, "Registration");
    }
    return response.body;
  }

  Future<bool> checkEmail(String email) async {
    String path = CustomerMicroserviceConstants.ENDPOINT_V1_CUSTOMERS +
        CustomerMicroserviceConstants.ENDPOINT_SUFFIX_VALIDATE +
        CustomerMicroserviceConstants.ENDPOINT_SUFFIX_EMAIL;
    var queryParameters = {'email': email};
    var uri = Uri.https(CustomerMicroserviceConstants.BASE_URL_CUSTOMERS, path,
        queryParameters);
    Map<String, String> headers = {"Content-type": "application/json"};

    var response = await get(
      uri,
      headers: headers,
    );
    if (response.statusCode != 200) {
      ErrorHandler.onError(response, "Email Verification");
    }
    var booleanResponse = jsonDecode(response.body);
    return booleanResponse[IAMConstants.USERNAME_TAKEN_KEY];
  }
}
