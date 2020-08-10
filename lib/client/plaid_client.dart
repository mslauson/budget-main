import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:main/constants/error_constants.dart';
import 'package:main/constants/global_constants.dart';
import 'package:main/constants/plaidConstants.dart';
import 'package:main/error/error_handler.dart';
import 'package:main/models/plaid/request/plaid_token_exchange_request.dart';
import 'package:main/models/plaid/response/plaid_token_exchange_response.dart';
import 'package:main/util/uri_builder.dart';

class PlaidClient {
  PlaidClient._();

  Future<PlaidTokenExchangeResponse> getAccessToken(
      PlaidTokenExchangeRequest request) async {
    Response response = await post(
        UriBuilder.plaidApiDev(PlaidConstants.URI_ACCESS_TOKEN),
        headers: GlobalConstants.BASIC_POST_HEADERS,
        body: request.toJson());
    if (response.statusCode != 200) {
      ErrorHandler.onError(response, ErrorConstants.ACCOUNTS_RETRIEVAL);
    }
    PlaidTokenExchangeResponse plaidResponse =
        PlaidTokenExchangeResponse.fromJson(jsonDecode(response.body));
    log(plaidResponse.toString());
    return plaidResponse;
  }
}
