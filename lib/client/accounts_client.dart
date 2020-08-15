import 'dart:convert';

import 'package:http/http.dart';
import 'package:main/constants/accountsMicroserviceConstants.dart';
import 'package:main/constants/error_constants.dart';
import 'package:main/error/error_handler.dart';
import 'package:main/models/accounts/AccessTokensResponse.dart';
import 'package:main/models/accounts/accounts_full_model.dart';

class AccountsClient {
   Future<AccountsFullModel> getAccountsForUser(String payload) async {
    Response response = await get(
        AccountsMicroserviceConstants.BASE_URL_ACCOUNTS +
            AccountsMicroserviceConstants.ENDPOINT_V1_ACCOUNTS +
            payload);
    if (response.statusCode != 200 && response.statusCode != 404) {
      ErrorHandler.onErrorClient(
          response, ErrorConstants.AUTHENTICATION_FAILURE);
    }
    return AccountsFullModel.fromJson(jsonDecode(response.body));
  }

  Future<AccessTokensResponse> getAccessTokensForUser(String email) async {
     Response response = await get(
         AccountsMicroserviceConstants.BASE_URL_ACCOUNTS +
             AccountsMicroserviceConstants.ENDPOINT_V1_ACCOUNTS +
             email +
             AccountsMicroserviceConstants.ENDPOINT_ACCESS_TOKENS);
     if (response.statusCode == 404) {
       return null;
     } else if (response.statusCode != 200) {
       ErrorHandler.onErrorClient(response, "AccessToken Retrieval");
    }
    return AccessTokensResponse.fromJson(jsonDecode(response.body));
  }
}
