import 'package:main/client/plaid_client.dart';
import 'package:main/constants/plaid_constants.dart';
import 'package:main/models/plaid/plaid_user.dart';
import 'package:main/models/plaid/request/link_token_request.dart';
import 'package:main/models/plaid/response/link_token_response.dart';
import 'package:plaid_flutter/plaid_flutter.dart';

class PlaidService {
  final PlaidClient _plaidClient = PlaidClient();

  void openLinkNewAccount(String phone) async {
    String linkToken = await _retrieveLinkTokenNewAccount(phone);
    LinkConfiguration
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
        countryCodes: PlaidConstants.COUNTRY_CODES
    );
  }
}
