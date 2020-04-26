import 'dart:convert';

import 'package:http/http.dart';
import 'package:main/constants/plaidMicroserviceConstants.dart';
import 'package:main/error/errorHandler.dart';
import 'package:main/model/plaid/tokenExchangeResponse.dart';

class PlaidMicroserviceClient{
  static Future<TokenExchangeResponse> exchangeToken(String publicToken) async {
    Response response = await get(
        PlaidMicroserviceConstants.URL + PlaidMicroserviceConstants.UTILITY_URI + PlaidMicroserviceConstants.TOKEN_URI + publicToken + PlaidMicroserviceConstants.EXCHANGE_URI,
       );
    if (response.statusCode != 200) {
      ErrorHandler.onError(response, "Authentication");
    }
    String responseBody = response.body;
    TokenExchangeResponse exchangeResponse = TokenExchangeResponse.fromJson(jsonDecode(responseBody));
    return exchangeResponse;
  }
}