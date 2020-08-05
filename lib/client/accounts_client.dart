import 'dart:convert';

import 'package:http/http.dart';
import 'package:main/constants/accountsMicroserviceConstants.dart';
import 'package:main/constants/error_constants.dart';
import 'package:main/error/error_handler.dart';
import 'package:main/models/accounts/AccessTokensResponse.dart';
import 'package:main/models/accounts/getAccountsResponse.dart';

class AccountsClient {
  static Future<GetAccountsResponse> getAccountsForUser(String payload) async {
    Response response = await get(
        AccountsMicroserviceConstants.BASE_URL_ACCOUNTS +
            AccountsMicroserviceConstants.ENDPOINT_V1_ACCOUNTS +
            payload);
    if (response.statusCode != 200 && response.statusCode != 404) {
      ErrorHandler.onError(response, ErrorConstants.AUTHENTICATION_FAILURE);
    }
    return GetAccountsResponse.fromJson(jsonDecode(response.body));
  }

  static Future<AccessTokensResponse> getAccessTokensForUser(
      String email) async {
    Response response = await get(
        AccountsMicroserviceConstants.BASE_URL_ACCOUNTS +
            AccountsMicroserviceConstants.ENDPOINT_V1_ACCOUNTS +
            email +
            AccountsMicroserviceConstants.ENDPOINT_ACCESS_TOKENS);
    if (response.statusCode == 404) {
      return null;
    } else if (response.statusCode != 200) {
      ErrorHandler.onError(response, "AccessToken Retrieval");
    }
    return AccessTokensResponse.fromJson(jsonDecode(response.body));
  }
}
