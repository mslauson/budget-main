import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:main/constants/error_constants.dart';
import 'package:main/constants/global_constants.dart';
import 'package:main/constants/plaid_constants.dart';
import 'package:main/error/error_handler.dart';
import 'package:main/models/plaid/request/UpdateWebhookRequestModel.dart';
import 'package:main/models/plaid/request/link_token_request.dart';
import 'package:main/models/plaid/request/plaid_generic_request.dart';
import 'package:main/models/plaid/request/plaid_institution_meta_request.dart';
import 'package:main/models/plaid/request/plaid_token_exchange_request.dart';
import 'package:main/models/plaid/request/plaid_transactions_request.dart';
import 'package:main/models/plaid/response/link_token_response.dart';
import 'package:main/models/plaid/response/plaid_accounts_response.dart';
import 'package:main/models/plaid/response/plaid_institution_meta_response.dart';
import 'package:main/models/plaid/response/plaid_item_response_model.dart';
import 'package:main/models/plaid/response/plaid_token_exchange_response.dart';
import 'package:main/models/plaid/response/plaid_transactions_response.dart';
import 'package:main/util/uri_builder.dart';

class PlaidClient {

  Future<PlaidTokenExchangeResponse> getAccessToken(
      PlaidTokenExchangeRequest request) async {
    Response response = await post(
        UriBuilder.plaidApiSandbox(PlaidConstants.URI_ACCESS_TOKEN),
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
        UriBuilder.plaidApiSandbox(PlaidConstants.URI_LINK_TOKEN),
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
        UriBuilder.plaidApiSandbox(PlaidConstants.URI_INSTITUTION_META),
        headers: GlobalConstants.BASIC_POST_HEADERS,
        body: jsonEncode(request.toJson()));
    if (response.statusCode != 200) {
      ErrorHandler.onErrorClient(response, ErrorConstants.ADDING_ACCOUNTS);
    }
    String body = response.body;
    PlaidInstitutionMetaResponse metaResponse =
        PlaidInstitutionMetaResponse.fromJson(jsonDecode(response.body));
    log(metaResponse.toString());
    return metaResponse;
  }

  Future<PlaidAccountsResponse> getAccounts(PlaidGenericRequest request) async {
    Response response = await post(
        UriBuilder.plaidApiSandbox(PlaidConstants.URI_GET_ACCOUNTS),
        headers: GlobalConstants.BASIC_POST_HEADERS,
        body: jsonEncode(request.toJson()));
    if (response.statusCode != 200) {
      ErrorHandler.onErrorClient(response, ErrorConstants.ADDING_ACCOUNTS);
    }
    String body = response.body;
    PlaidAccountsResponse accountsResponse =
        PlaidAccountsResponse.fromJson(jsonDecode(response.body));
    log(accountsResponse.toString());
    return accountsResponse;
  }

  Future<PlaidItemResponseModel> getItemId(PlaidGenericRequest request) async {
    Response response = await post(
        UriBuilder.plaidApiSandbox(PlaidConstants.URI_GET_ITEM),
        headers: GlobalConstants.BASIC_POST_HEADERS,
        body: jsonEncode(request.toJson()));
    if (response.statusCode != 200) {
      ErrorHandler.onErrorClient(response, ErrorConstants.ADDING_ACCOUNTS);
    }
    PlaidItemResponseModel itemResponseModel =
        PlaidItemResponseModel.fromJson(jsonDecode(response.body));
    log(response.body);
    return itemResponseModel;
  }

  Future<PlaidTransactionsResponse> getTransactions(
      PlaidTransactionsRequest request) async {
    Response response = await post(
        UriBuilder.plaidApiSandbox(PlaidConstants.URI_GET_TRANSACTIONS),
        headers: GlobalConstants.BASIC_POST_HEADERS,
        body: jsonEncode(request.toJson()));
    if (response.statusCode != 200) {
      ErrorHandler.onErrorClient(response, ErrorConstants.ADDING_ACCOUNTS);
    }
    PlaidTransactionsResponse transactionsResponse =
        PlaidTransactionsResponse.fromJson(jsonDecode(response.body));
    log(response.body);
    return transactionsResponse;
  }

  Future<String> updateWebhook(UpdateWebhookRequestModel request) async {
    Response response = await post(
        UriBuilder.plaidApiSandbox(PlaidConstants.URI_UPDATE_WEBHOOK),
        headers: GlobalConstants.BASIC_POST_HEADERS,
        body: jsonEncode(request.toJson()));
    if (response.statusCode != 200) {
      ErrorHandler.onErrorClient(response, ErrorConstants.ADDING_ACCOUNTS);
    }
    log(response.body);
    return response.body;
  }

  Future<String> removeItem(PlaidGenericRequest request) async {
    Response response = await post(
        UriBuilder.plaidApiSandbox(PlaidConstants.URI_REMOVE_ITEM),
        headers: GlobalConstants.BASIC_POST_HEADERS,
        body: jsonEncode(request.toJson()));
    if (response.statusCode != 200) {
      ErrorHandler.onErrorClient(response, ErrorConstants.REMOVING_ACCOUNTS);
    }
    log(response.body);
    return response.body;
  }
}
