import 'package:flutter/cupertino.dart';
import 'package:main/models/accounts/response/accounts_response.dart';
import 'package:main/service/accounts/accounts_service.dart';

class HomeInitializationService {
  final AccountsService _accountsService = AccountsService();
  final Function(AccountsResponseModel accountsFullModel) getAccounts;
  final Function() getTransactions;
  final Function() getBudgets;
  final Function() getExpenses;
  final Function() getCustomer;

  HomeInitializationService(
      {this.getTransactions,
      this.getBudgets,
      this.getExpenses,
      this.getCustomer,
      this.getAccounts});

  Future<void> loadData(String phone, BuildContext context) async {
    getAccounts(await getAccountsByPhone(phone));
  }

  Future<AccountsResponseModel> getAccountsByPhone(String phone) async =>
      await _accountsService.getAccountsForUser(phone);
}
