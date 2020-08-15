import 'dart:developer';

import 'package:main/client/plaid_client.dart';
import 'package:main/constants/error_constants.dart';
import 'package:main/constants/plaid_constants.dart';
import 'package:main/error/error_handler.dart';
import 'package:main/models/plaid/plaid_user.dart';
import 'package:main/models/plaid/request/link_token_request.dart';
import 'package:main/models/plaid/response/link_token_response.dart';
import 'package:plaid_flutter/plaid_flutter.dart';

class PlaidService {
  String _institutionId;
  String _institutionName;
  final PlaidClient _plaidClient = PlaidClient();

  void openLinkNewAccount(String phone) async {
    LinkConfiguration config;
    PlaidLink plaidLink;
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
        clientId: PlaidConstants.CLIENT_ID_DEV,
        secret: PlaidConstants.CLIENT_SECRET_DEV,
        clientName: PlaidConstants.CLIENT_NAME,
        language: PlaidConstants.LANGUAGE,
        user: PlaidUser(clientUserId: phone),
        products: PlaidConstants.IDENTITY_PRODUCT,
        countryCodes: PlaidConstants.COUNTRY_CODES);
  }

  void _getMetaData() {}

  void _onSuccessLinkCallback(
      String publicToken, LinkSuccessMetadata metadata) {
    print("onSuccess: $publicToken, metadata: ${metadata.description()}");
  }

  void _onEventLinkCallBack(String event, LinkEventMetadata metadata) {
    _institutionId = metadata.institutionId;
    _institutionName = metadata.institutionName;
  }

  void _onExitLinkCallBack(String error, LinkExitMetadata metadata) {
    log("error: $error, metadata: ${metadata.description()}");
    ErrorHandler.onError(ErrorConstants.ADDING_ACCOUNTS);
  }
}
