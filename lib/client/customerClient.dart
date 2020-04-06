import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:main/model/signUpForm.dart';

class CustomerClient {
  addCustomer(String payload) async {
    String url = 'http://customer-microservice-dev.blossombudgeting.io/api/v1/customer';
    Map<String, String> headers = {"Content-type": "application/json"};
    
    Response response = await post(url, headers: headers, body: payload);
  
    int statusCode = response.statusCode;
      log(statusCode.toString());
    String body = response.body;
    log(body);
    return jsonDecode(body);
  }
}
