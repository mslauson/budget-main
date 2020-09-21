import 'dart:developer';

import 'package:main/client/plaid_client.dart';
import 'package:main/constants/error_constants.dart';
import 'package:main/constants/plaid_constants.dart';
import 'package:main/error/error_handler.dart';
import 'package:main/models/accounts/account.dart';
import 'package:main/models/accounts/accounts_full_model.dart';
import 'package:main/models/accounts/institution.dart';
import 'package:main/models/plaid/plaid_user.dart';
import 'package:main/models/plaid/request/link_token_request.dart';
import 'package:main/models/plaid/request/plaid_accounts_request.dart';
import 'package:main/models/plaid/request/plaid_institution_meta_request.dart';
import 'package:main/models/plaid/request/plaid_request_options.dart';
import 'package:main/models/plaid/request/plaid_token_exchange_request.dart';
import 'package:main/models/plaid/request/plaid_transactions_request.dart';
import 'package:main/models/plaid/response/link_token_response.dart';
import 'package:main/models/plaid/response/plaid_accounts_response.dart';
import 'package:main/models/plaid/response/plaid_institution_meta_response.dart';
import 'package:main/models/plaid/response/plaid_transactions_response.dart';
import 'package:main/models/plaid/transaction_options.dart';
import 'package:main/service/accounts/accounts_service.dart';
import 'package:main/service/transactions/transactions_service.dart';
import 'package:plaid_flutter/plaid_flutter.dart';

class PlaidService {
  String _institutionId;
  String _institutionName;
  String _phone;
  final PlaidClient _plaidClient = PlaidClient();
  final AccountsService _accountsService = AccountsService();
  final TransactionsService _transactionsService = TransactionsService();
  final Function() onfinish;

  PlaidService({this.onfinish});

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

  Future<PlaidTransactionsResponse> getTransactionsFromPlaid(String accessToken,
      String start, String finish, TransactionOptions options) async {
    PlaidTransactionsRequest transactionsRequest = PlaidTransactionsRequest(
        clientId: PlaidConstants.CLIENT_ID_SANDBOX,
        secret: PlaidConstants.CLIENT_SECRET_SANDBOX,
        accessToken: accessToken,
        startDate: start,
        endDate: finish,
        options: options);
    return await _plaidClient.getTransactions(transactionsRequest);
  }

  Future<String> _retrieveLinkTokenNewAccount(String phone) async {
    LinkTokenResponse response =
        await _plaidClient.getLinkToken(_buildLinkRequestNewAccount(phone));
    return response.linkToken;
  }

  LinkTokenRequest _buildLinkRequestNewAccount(String phone) {
    return LinkTokenRequest(
        clientId: PlaidConstants.CLIENT_ID_SANDBOX,
        secret: PlaidConstants.CLIENT_SECRET_SANDBOX,
        clientName: PlaidConstants.CLIENT_NAME,
        language: PlaidConstants.LANGUAGE,
        user: PlaidUser(clientUserId: phone),
        products: PlaidConstants.TRANSACTION_PRODUCT,
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
        .then((tokenResponse) async =>
    {
              accountsResponse = await _plaidClient.getAccounts(
                  _buildAccountsRequest(tokenResponse.accessToken)),
              await _accountsService.addAccount(_buildAccountsModel(
                  tokenResponse.accessToken,
                  metadata.linkSessionId,
                  accountsResponse.accounts,
                  metaResponse)),
              _finializeItemWithTransactions(tokenResponse.accessToken)
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
        publicToken: publicToken);
  }

  PlaidAccountsRequest _buildAccountsRequest(String accessToken) {
    return PlaidAccountsRequest(
        clientId: PlaidConstants.CLIENT_ID_SANDBOX,
        secret: PlaidConstants.CLIENT_SECRET_SANDBOX,
        accessToken: accessToken);
  }

  AccountsFullModel _buildAccountsModel(
      String accessToken,
      String linkSessionId,
      List<Account> accounts,
      PlaidInstitutionMetaResponse metaResponse) {
    accounts.forEach((e) => e.id = e.accountId);
    return AccountsFullModel(
        phone: _phone,
        accounts: accounts,
        institution: _buildInstitution(metaResponse),
        accessToken: accessToken,
        linkSessionId: linkSessionId);
  }

  Institution _buildInstitution(PlaidInstitutionMetaResponse metaResponse) {
    return Institution(
        name: _institutionName,
        institutionId: _institutionId,
        logo: metaResponse.institution.logo,
        primaryColor: metaResponse.institution.primaryColor,
        url: metaResponse.institution.url);
  }

  Future<void> _finializeItemWithTransactions(String accessToken) async {
    //TODO: Figure out the alternative for this
    //maybe add a loading indicator
    await Future.delayed(Duration(seconds: 30));
    PlaidTransactionsResponse transactionsResponse = await getTransactionsFromPlaid(
        accessToken,
        _parseDate(DateTime.now().subtract(Duration(days: 30))),
        _parseDate(DateTime.now()),
        TransactionOptions(count: 500));
    await _transactionsService.addTransactions(transactionsResponse, _phone);
    onfinish();
  }

  String _parseDate(DateTime date) {
    String dateString = date.toIso8601String();
    return dateString.split("T")[0];
  }


}
