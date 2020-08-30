import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:main/constants/accounts_microservice_client.dart';
import 'package:main/constants/error_constants.dart';
import 'package:main/constants/global_constants.dart';
import 'package:main/error/error_handler.dart';
import 'package:main/models/accounts/AccessTokensResponse.dart';
import 'package:main/models/accounts/accounts_full_model.dart';
import 'package:main/util/uri_builder.dart';

class AccountsClient {
   Future<AccountsFullModel> getAccountsForUser(String payload) async {
    Response response = await get(UriBuilder.blossomDevWithPath(
        AccountsMicroserviceConstants.SERVICE, 1, payload));
    if (response.statusCode != 200 && response.statusCode != 404) {
      ErrorHandler.onErrorClient(response, ErrorConstants.ACCOUNTS_RETRIEVAL);
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

  Future<AccountsFullModel> addAccount(AccountsFullModel request) async {
    Response response = await post(
        UriBuilder.blossomDev(AccountsMicroserviceConstants.SERVICE, 1),
        headers: GlobalConstants.BASIC_POST_HEADERS,
        body: jsonEncode(request.toJson()));
    if (response.statusCode != 200) {
      ErrorHandler.onErrorClient(response, ErrorConstants.ADDING_ACCOUNTS);
    }
    AccountsFullModel accountsResponse =
        AccountsFullModel.fromJson(jsonDecode(response.body));
    log(accountsResponse.toString());
    return accountsResponse;
  }
}
