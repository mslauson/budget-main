import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:main/constants/error_constants.dart';
import 'package:main/constants/global_constants.dart';
import 'package:main/constants/plaid_constants.dart';
import 'package:main/error/error_handler.dart';
import 'package:main/models/plaid/request/link_token_request.dart';
import 'package:main/models/plaid/request/plaid_institution_meta_request.dart';
import 'package:main/models/plaid/request/plaid_token_exchange_request.dart';
import 'package:main/models/plaid/response/link_token_response.dart';
import 'package:main/models/plaid/response/plaid_institution_meta_response.dart';
import 'package:main/models/plaid/response/plaid_token_exchange_response.dart';
import 'package:main/util/uri_builder.dart';

class PlaidClient {

  Future<PlaidTokenExchangeResponse> getAccessToken(
      PlaidTokenExchangeRequest request) async {
    Response response = await post(
        UriBuilder.plaidApiDev(PlaidConstants.URI_ACCESS_TOKEN),
        headers: GlobalConstants.BASIC_POST_HEADERS,
        body: jsonEncode(request.toJson()));
    if (response.statusCode != 200) {
      ErrorHandler.onErrorClient(response, ErrorConstants.ACCOUNTS_RETRIEVAL);
    }
    PlaidTokenExchangeResponse plaidResponse =
        PlaidTokenExchangeResponse.fromJson(jsonDecode(response.body));
    log(plaidResponse.toString());
    return plaidResponse;
  }

  Future<LinkTokenResponse> getLinkToken(LinkTokenRequest request) async {
    Response response = await post(
        UriBuilder.plaidApiDev(PlaidConstants.URI_LINK_TOKEN),
        headers: GlobalConstants.BASIC_POST_HEADERS,
        body: jsonEncode(request.toJson()));
    if (response.statusCode != 200) {
      ErrorHandler.onErrorClient(response, ErrorConstants.ADDING_ACCOUNTS);
    }
    LinkTokenResponse plaidResponse =
        LinkTokenResponse.fromJson(jsonDecode(response.body));
    log(plaidResponse.toString());
    return plaidResponse;
  }

  Future<PlaidInstitutionMetaResponse> getInstitutionMetaData(
      PlaidInstitutionMetaRequest request) async {
    Response response = await post(
        UriBuilder.plaidApiDev(PlaidConstants.URI_INSTITUTION_META),
        headers: GlobalConstants.BASIC_POST_HEADERS,
        body: jsonEncode(request.toJson()));
    if (response.statusCode != 200) {
      ErrorHandler.onErrorClient(response, ErrorConstants.ADDING_ACCOUNTS);
    }
    PlaidInstitutionMetaResponse metaResponse =
        PlaidInstitutionMetaResponse.fromJson(jsonDecode(response.body));
    return metaResponse;
  }
}
