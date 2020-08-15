import 'package:main/client/accounts_client.dart';
import 'package:main/service/plaid/plaid_service.dart';

class AccountsService {
  final AccountsClient _accountsClient = AccountsClient();
  final PlaidService _plaidService = PlaidService();

//  void addAccount(String phone, LinkSuccessMetadata metadata) {
//    metadata.accounts.
//    AccountsFullModel _buildAccountsModel(String phone,
//        LinkSuccessMetadata metadata) {
//      AccountsFullModel(
//          phone: phone,
//          accessToken: metadata.accounts[0]
//      )
//    }
}
