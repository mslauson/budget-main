import 'dart:convert';

import 'package:http/http.dart';
import 'package:main/constants/UrlConstants.dart';
import 'package:main/constants/plaidMicroserviceConstants.dart';
import 'package:main/error/error_handler.dart';
import 'package:main/models/plaid/genericStatusResponseModel.dart';
import 'package:main/models/plaid/tokenExchangeResponse.dart';

@Deprecated('In favor of writing new client in dart')
class PlaidMicroserviceClient {
  static Future<TokenExchangeResponse> exchangeToken(String publicToken) async {
    Response response = await get(
      PlaidMicroserviceConstants.URL +
          PlaidMicroserviceConstants.UTILITY_URI +
          PlaidMicroserviceConstants.TOKEN_URI +
          publicToken +
          PlaidMicroserviceConstants.EXCHANGE_URI,
    );
    if (response.statusCode != 200) {
      ErrorHandler.onErrorClient(response, "Access Token");
    }
    String responseBody = response.body;
    TokenExchangeResponse exchangeResponse =
    TokenExchangeResponse.fromJson(jsonDecode(responseBody));
    return exchangeResponse;
  }

  static Future<bool> addAccounts(String payload) async {
    Response response = await put(
        PlaidMicroserviceConstants.URL +
            PlaidMicroserviceConstants.CLIENT_URI +
            PlaidMicroserviceConstants.ACCOUNTS_URI,
        headers: UrlConstants.JSON_HEADER,
        body: payload);
    if (response.statusCode != 200) {
      ErrorHandler.onErrorClient(response, "Adding Accounts");
    }
    String responseBody = response.body;
    GenericSuccessResponseModel exchangeResponse =
    GenericSuccessResponseModel.fromJson(jsonDecode(responseBody));
    return exchangeResponse.success;
  }

  static Future<bool> addTransactions(String payload) async {
    Response response = await put(
        PlaidMicroserviceConstants.URL +
            PlaidMicroserviceConstants.CLIENT_URI +
            PlaidMicroserviceConstants.TRANSACTIONS_URI,
        headers: UrlConstants.JSON_HEADER,
        body: payload);
    if (response.statusCode != 200) {
      ErrorHandler.onErrorClient(response, "Adding Transactions");
    }
    String responseBody = response.body;
    GenericSuccessResponseModel exchangeResponse =
    GenericSuccessResponseModel.fromJson(jsonDecode(responseBody));
    return exchangeResponse.success;
  }
}