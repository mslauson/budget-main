import 'dart:convert';

import 'package:http/http.dart';
import 'package:main/constants/iamConstants.dart';

import 'package:main/error/errorHandler.dart';

class CustomerClient {
  Future<String> addCustomer(String payload) async {
    String url =
        'http://customer-microservice-dev.blossombudgeting.io/api/v1/customer';
    Map<String, String> headers = {"Content-type": "application/json"};

    var response = await post(url, headers: headers, body: payload);
    if(response.statusCode != 200){
      ErrorHandler.onError(response, "Registration");
    }
    return response.body;
  }

  
  Future<bool> checkUserName(String payload)  async {
    String url =
        'http://customer-microservice-dev.blossombudgeting.io/api/v1/customer/validate/' + payload;
    Map<String, String> headers = {"Content-type": "application/json"};

    var response = await get(url, headers: headers );
    if(response.statusCode != 200){
      ErrorHandler.onError(response, "Username Verification");
    }
    var booleanResponse = jsonDecode(response.body);
    return booleanResponse[IAMConstants.USERNAME_TAKEN_KEY];
  }
}
