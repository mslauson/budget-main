import 'package:main/client/accounts_client.dart';
import 'package:main/models/accounts/accounts_full_model.dart';
import 'package:main/models/accounts/response/accounts_response.dart';

class AccountsService {
  final AccountsClient _accountsClient = AccountsClient();

  void addAccount(AccountsFullModel accountsFullModel) {
    _accountsClient.addAccount(accountsFullModel);
  }

  Future<AccountsResponseModel> getAccountsForUser(String phone) {
    return _accountsClient.getAccountsForUser(phone);
  }
}
