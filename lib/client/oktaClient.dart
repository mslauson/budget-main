import 'dart:convert';

import 'package:http/http.dart';
import 'package:main/constants/UrlConstants.dart';
import 'package:main/constants/oktaConstants.dart';
import 'package:main/error/errorHandler.dart';
import 'package:main/models/iam/authenticateResponse.dart';

class OktaClient {
  Future addUserToOkta(String payload) async {
    Response response = await post(
        UrlConstants.OKTA_BASE_DEV + UrlConstants.OKTA_ADD_USER,
        headers: OktaConstants.OTIKA_DEV_HEDERS,
        body: payload);
    if (response.statusCode != 200) {
      ErrorHandler.onError(response, "Registration");
    }
    return response.body;
  }

   Future<AuthenticateResponse> authenticate(String payload) async {
    Response response = await post(
        UrlConstants.OKTA_BASE_DEV + UrlConstants.OKTA_AUTHENTICATE,
        headers: OktaConstants.OTIKA_DEV_HEDERS,
        body: payload);
    if (response.statusCode != 200) {
      ErrorHandler.onError(response, "Authentication");
    }
    String responseBody = response.body;
  AuthenticateResponse authenticateResponse = AuthenticateResponse.fromJson(jsonDecode(responseBody));
    
    return authenticateResponse;
  }
}
