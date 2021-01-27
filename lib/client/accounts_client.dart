import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:main/constants/accounts_microservice_client.dart';
import 'package:main/constants/error_constants.dart';
import 'package:main/constants/global_constants.dart';
import 'package:main/error/error_handler.dart';
import 'package:main/models/accounts/AccessTokensResponse.dart';
import 'package:main/models/accounts/accounts_full_model.dart';
import 'package:main/models/accounts/delete_account_request_model.dart';
import 'package:main/models/accounts/response/account_meta_response.dart';
import 'package:main/models/accounts/response/accounts_response.dart';
import 'package:main/models/accounts/update_accounts_request_model.dart';
import 'package:main/models/plaid/genericStatusResponseModel.dart';
import 'package:main/security/blossom_encryption_utility.dart';
import 'package:main/util/model_encryption_utility.dart';
import 'package:main/util/uri_builder.dart';

class AccountsClient {
  final _modelEncryption = ModelEncryptionUtility();
  final _encryptionUtility = BlossomEncryptionUtility();

  Future<AccountsResponseModel> getAccountsForUser(String phone) async {
    String encryptedPhone = _encryptionUtility.encrypt(phone);
    encryptedPhone = Uri.encodeComponent(encryptedPhone);
    String url =
        UriBuilder.blossomDev(AccountsMicroserviceConstants.SERVICE, 1);
    url = url + "?phone=" + encryptedPhone;
    Response response = await get(url);
    if (response.statusCode != 200 && response.statusCode != 404) {
      ErrorHandler.onErrorClient(response, ErrorConstants.ACCOUNTS_RETRIEVAL);
    }
    AccountsResponseModel accountsResponseModel =
        AccountsResponseModel.fromJson(jsonDecode(response.body));
    return _modelEncryption.decryptAccountsResponseModel(accountsResponseModel);
  }

  Future<AccessTokensResponse> getAccessTokensForUser(String phone) async {
    String encryptedPhone = _encryptionUtility.encrypt(phone);
    encryptedPhone = Uri.encodeComponent(encryptedPhone);
    String url = UriBuilder.blossomDevWithUri(
        AccountsMicroserviceConstants.SERVICE,
        1,
        AccountsMicroserviceConstants.ENDPOINT_ACCESS_TOKENS);
    url = url + "?phone=" + encryptedPhone;
    Response response = await get(url);
    if (response.statusCode == 404) {
      return null;
    } else if (response.statusCode != 200) {
      ErrorHandler.onErrorClient(response, "AccessToken Retrieval");
    }
    AccessTokensResponse accessTokensResponse =
        AccessTokensResponse.fromJson(jsonDecode(response.body));
    return _modelEncryption.decryptAccessTokensResponse(accessTokensResponse);
  }

  Future<AccountMetaResponse> getAccountMetaDataForUser(String phone) async {
    String encryptedPhone = _encryptionUtility.encrypt(phone);
    encryptedPhone = Uri.encodeComponent(encryptedPhone);
    String url = UriBuilder.blossomDevWithUri(
        AccountsMicroserviceConstants.SERVICE,
        1,
        AccountsMicroserviceConstants.ENDPOINT_META);
    url = url + "?phone=" + encryptedPhone;
    Response response = await get(url);
    if (response.statusCode != 200 && response.statusCode != 404) {
      ErrorHandler.onErrorClient(response, "AccessToken Retrieval");
    }
    AccountMetaResponse accountMetaResponse =
        AccountMetaResponse.fromJson(jsonDecode(response.body));
    return _modelEncryption.decryptAccountMetaResponse(accountMetaResponse);
  }

  Future<AccountsFullModel> addAccount(AccountsFullModel request) async {
    AccountsFullModel encryptedRequest =
        _modelEncryption.encryptAccountsFullModel(request);
    Response response = await post(
        UriBuilder.blossomDev(AccountsMicroserviceConstants.SERVICE, 1),
        headers: GlobalConstants.BASIC_POST_HEADERS,
        body: jsonEncode(encryptedRequest.toJson()));
    if (response.statusCode != 200) {
      ErrorHandler.onErrorClient(response, ErrorConstants.ADDING_ACCOUNTS);
    }
    AccountsFullModel accountsResponse =
        AccountsFullModel.fromJson(jsonDecode(response.body));
    return _modelEncryption.decryptAccountsFullModel(accountsResponse);
  }

  Future<GenericSuccessResponseModel> deleteAccount(DeleteAccountRequestModel request) async {
    DeleteAccountRequestModel encryptedRequest =
        _modelEncryption.encryptDeleteAccountModel(request);
    Response response = await put(
        UriBuilder.blossomDevWithUri(AccountsMicroserviceConstants.SERVICE, 1,
            AccountsMicroserviceConstants.ENDPOINT_DELETE),
        headers: GlobalConstants.BASIC_POST_HEADERS,
        body: jsonEncode(encryptedRequest.toJson()));
    if (response.statusCode != 200) {
      ErrorHandler.onErrorClient(response, ErrorConstants.REMOVING_ACCOUNTS);
    }
    GenericSuccessResponseModel deleteResponse =
        GenericSuccessResponseModel.fromJson(jsonDecode(response.body));
    log(deleteResponse.toString());
    return deleteResponse;
  }

  Future<GenericSuccessResponseModel> updateToken(UpdateAccountRequestModel request) async {
    UpdateAccountRequestModel encryptedModel =
        _modelEncryption.encryptUpdateAccountModel(request);
    Response response = await put(
        UriBuilder.blossomDevWithUri(AccountsMicroserviceConstants.SERVICE, 1,
            AccountsMicroserviceConstants.ENDPOINT_TOKEN),
        headers: GlobalConstants.BASIC_POST_HEADERS,
        body: jsonEncode(encryptedModel.toJson()));
    if (response.statusCode != 200) {
      ErrorHandler.onErrorClient(response, ErrorConstants.RE_ADDING_ACCOUNTS);
    }
    GenericSuccessResponseModel deleteResponse =
        GenericSuccessResponseModel.fromJson(jsonDecode(response.body));
    log(deleteResponse.toString());
    return deleteResponse;
  }
}
