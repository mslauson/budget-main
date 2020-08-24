import 'dart:developer';

import 'package:main/client/plaid_client.dart';
import 'package:main/constants/error_constants.dart';
import 'package:main/constants/plaid_constants.dart';
import 'package:main/error/error_handler.dart';
import 'package:main/models/accounts/accounts.dart';
import 'package:main/models/accounts/accounts_full_model.dart';
import 'package:main/models/accounts/institution.dart';
import 'package:main/models/plaid/plaid_user.dart';
import 'package:main/models/plaid/request/link_token_request.dart';
import 'package:main/models/plaid/request/plaid_accounts_request.dart';
import 'package:main/models/plaid/request/plaid_institution_meta_request.dart';
import 'package:main/models/plaid/request/plaid_request_options.dart';
import 'package:main/models/plaid/request/plaid_token_exchange_request.dart';
import 'package:main/models/plaid/response/link_token_response.dart';
import 'package:main/models/plaid/response/plaid_accounts_response.dart';
import 'package:main/models/plaid/response/plaid_institution_meta_response.dart';
import 'package:main/service/accounts/accounts_service.dart';
import 'package:plaid_flutter/plaid_flutter.dart';

class PlaidService {
  String _institutionId;
  String _institutionName;
  String _phone;
  final PlaidClient _plaidClient = PlaidClient();
  final AccountsService _accountsService = AccountsService();

  void openLinkNewAccount(String phone) async {
    LinkConfiguration config;
    PlaidLink plaidLink;
    _phone = phone;
    _retrieveLinkTokenNewAccount(phone)
        .then((linkToken) => {
              config = LinkConfiguration(linkToken: linkToken),
              plaidLink = PlaidLink(
                  configuration: config,
                  onSuccess: _onSuccessLinkCallback,
                  onEvent: _onEventLinkCallBack,
                  onExit: _onExitLinkCallBack),
              plaidLink.open()
            })
        .catchError((error) => ErrorHandler.showError(error));
  }

  Future<String> _retrieveLinkTokenNewAccount(String phone) async {
    LinkTokenResponse response = await _plaidClient.getLinkToken(
        _buildLinkRequestNewAccount(phone));
    return response.linkToken;
  }

  LinkTokenRequest _buildLinkRequestNewAccount(String phone) {
    return LinkTokenRequest(
        clientId: PlaidConstants.CLIENT_ID_SANDBOX,
        secret: PlaidConstants.CLIENT_SECRET_SANDBOX,
        clientName: PlaidConstants.CLIENT_NAME,
        language: PlaidConstants.LANGUAGE,
        user: PlaidUser(clientUserId: phone),
        products: PlaidConstants.IDENTITY_PRODUCT,
        countryCodes: PlaidConstants.COUNTRY_CODES);
  }

  void _onSuccessLinkCallback(String publicToken,
      LinkSuccessMetadata metadata) async {
    log("onSuccess: $publicToken, metadata: ${metadata.description()}");
    PlaidAccountsResponse accountsResponse;
    PlaidInstitutionMetaResponse metaResponse =
        await _plaidClient.getInstitutionMetaData(_buildMetaRequest());
    _plaidClient
        .getAccessToken(_buildTokenExchangeRequest(publicToken))
        .then((tokenResponse) async => {
              accountsResponse = await _plaidClient.getAccounts(
                  _buildAccountsRequest(tokenResponse.accessToken)),
              await _accountsService.addAccount(_buildAccountsModel(
                  tokenResponse.accessToken,
                  metadata.linkSessionId,
                  accountsResponse.accounts, metaResponse))
    });
  }

  void _onEventLinkCallBack(String event, LinkEventMetadata metadata) {
    _institutionId = metadata.institutionId;
    _institutionName = metadata.institutionName;
  }

  void _onExitLinkCallBack(String error, LinkExitMetadata metadata) {
    log("error: $error, metadata: ${metadata.description()}");
    ErrorHandler.onError(ErrorConstants.ADDING_ACCOUNTS);
  }

  PlaidInstitutionMetaRequest _buildMetaRequest() {
    return PlaidInstitutionMetaRequest(
        institutionId: _institutionId,
        clientId: PlaidConstants.CLIENT_ID_SANDBOX,
        secret: PlaidConstants.CLIENT_SECRET_SANDBOX,
        options: Options(includeOptionalMetadata: true));
  }

  PlaidTokenExchangeRequest _buildTokenExchangeRequest(String publicToken) {
    return PlaidTokenExchangeRequest(
        clientId: PlaidConstants.CLIENT_ID_SANDBOX,
        secret: PlaidConstants.CLIENT_SECRET_SANDBOX,
        publicToken: publicToken
    );
  }

  PlaidAccountsRequest _buildAccountsRequest(String accessToken) {
    return PlaidAccountsRequest(
        clientId: PlaidConstants.CLIENT_ID_SANDBOX,
        secret: PlaidConstants.CLIENT_SECRET_SANDBOX,
        accessToken: accessToken
    );
  }

  AccountsFullModel _buildAccountsModel(String accessToken,
      String linkSessionId, List<Accounts> accounts,
      PlaidInstitutionMetaResponse metaResponse) {
//    accounts.map((e) => {e.id=e.accountId});
    return AccountsFullModel(
        phone: _phone,
        accounts: accounts,
        institution: _buildInstitution(metaResponse),
        accessToken: accessToken,
        linkSessionId: linkSessionId
    );
  }

  Institution _buildInstitution(PlaidInstitutionMetaResponse metaResponse) {
    return Institution(
        name: _institutionName,
        institutionId: _institutionId,
        logo: metaResponse.logo,
        primaryColor: metaResponse.primaryColor,
        url: metaResponse.url
    );
  }
}
