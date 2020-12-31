import 'package:flutter/cupertino.dart';
import 'package:main/models/accounts/accounts_sccoped_model.dart';
import 'package:main/models/transactions/transactions_scoped_model.dart';
import 'package:main/service/accounts/accounts_service.dart';
import 'package:main/service/transactions/transactions_service.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeInitializationService {
  final AccountsService _accountsService = AccountsService();
  final TransactionsService _transactionsService = TransactionsService();

  HomeInitializationService();

  Future<void> loadData(String phone, BuildContext context) async {
    await getAccountsByPhone(phone, context);
  }

  Future<void> getAccountsByPhone(String phone, BuildContext context) async =>
      ScopedModel.of<AccountsScopedModel>(context, rebuildOnChange: true)
          .responseModel = await _accountsService.getAccountsForUser(phone);

  Future<void> getTransactionsByPhone(
          String phone, BuildContext context) async =>
      ScopedModel.of<TransactionsScopedModel>(context, rebuildOnChange: true)
              .responseModel =
          await _transactionsService.getTransactionsByPhone(phone);
}
