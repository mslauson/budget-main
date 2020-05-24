import 'dart:convert';

import 'package:http/http.dart';
import 'package:main/constants/accountsMicroserviceConstants.dart';
import 'package:main/error/errorHandler.dart';
import 'package:main/model/accounts/AccessTokensResponse.dart';
import 'package:main/model/accounts/getAccountsResponse.dart';

class AccountsClient {
  static Future<GetAccountsResponse> getAccountsForUser(String payload) async {
    Response response = await get(AccountsMicroserviceConstants.ACCOUNTS_BASE +
        AccountsMicroserviceConstants.ACCOUNTS_BASE_URI +
        payload);
    if (response.statusCode != 200 && response.statusCode != 404) {
      ErrorHandler.onError(response, "Account Retrieval");
    }
    return GetAccountsResponse.fromJson(jsonDecode(response.body));
  }

  static Future<AccessTokensResponse> getAccessTokensForUser(
      String email) async {
    Response response = await get(AccountsMicroserviceConstants.ACCOUNTS_BASE +
        AccountsMicroserviceConstants.ACCOUNTS_BASE_URI +
        email +
        AccountsMicroserviceConstants.ACCESS_TOKENS_URI);
    if (response.statusCode == 404) {
      return null;
    } else if (response.statusCode != 200) {
      ErrorHandler.onError(response, "AccessToken Retrieval");
    }
    return AccessTokensResponse.fromJson(jsonDecode(response.body));
  }
}
