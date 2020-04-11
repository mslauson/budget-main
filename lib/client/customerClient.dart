import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:main/constants/signUpConstants.dart';

class CustomerClient {
  Future<String> addCustomer(String payload) async {
    String url =
        'http://customer-microservice-dev.blossombudgeting.io/api/v1/customer';
    Map<String, String> headers = {"Content-type": "application/json"};

    var response = await post(url, headers: headers, body: payload);
    if(response.statusCode != 200){
      onError(response, "Registration");
    }
    return response.body;
  }

  onError(Response response, String context){
    log(context + "failed with status code: "+response.statusCode.toString()+" response: "+response.body+"");
    throw context + " failed.";
  }

  Future<bool> checkUserName(String payload)  async {
    String url =
        'http://customer-microservice-dev.blossombudgeting.io/api/v1/customer/validate/' + payload;
    Map<String, String> headers = {"Content-type": "application/json"};

    var response = await get(url, headers: headers );
    if(response.statusCode != 200){
      onError(response, "Username Verification");
    }
    var booleanResponse = jsonDecode(response.body);
    return booleanResponse[SignUpConstants.USERNAME_TAKEN_KEY];
  }
}
