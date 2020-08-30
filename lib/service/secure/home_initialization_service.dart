import 'package:flutter/cupertino.dart';
import 'package:main/models/accounts/accounts_full_model.dart';
import 'package:main/service/accounts/accounts_service.dart';

class HomeInitializationService {
  final AccountsService _accountsService = AccountsService();
  final Function(AccountsFullModel accountsFullModel) getAccounts;
  final Function() getTransactions;
  final Function() getBudgets;
  final Function() getExpenses;
  final Function() getCustomer;

  HomeInitializationService(
      this.getTransactions, this.getBudgets, this.getExpenses, this.getCustomer,
      {this.getAccounts});

  Future<void> loadData(String phone, BuildContext context) async {
    getAccounts(await getAccountsByPhone(phone));
  }

  Future<AccountsFullModel> getAccountsByPhone(String phone) async =>
      await _accountsService.getAccountsForUser(phone);
}
