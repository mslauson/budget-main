import 'package:flutter/cupertino.dart';
import 'package:main/models/global/activeUser.dart';
import 'package:main/service/accounts/accounts_service.dart';
import 'package:main/service/budgets/budgets_service.dart';
import 'package:main/service/transactions/transactions_service.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeInitializationService {
  final AccountsService _accountsService = AccountsService();
  final TransactionsService _transactionsService = TransactionsService();
  final BudgetsService _budgetsService = BudgetsService();

  HomeInitializationService();

  Future<void> loadData(String phone, BuildContext context) async {
    await _getAccountsByPhone(phone, context);
    await _getMetaByPhone(phone, context);
    await _getTransactionsByPhone(phone, context);
    await _getBudgetsByPhone(phone, context);
  }

  Future<void> _getAccountsByPhone(String phone, BuildContext context) async =>
      ScopedModel.of<ActiveUser>(context, rebuildOnChange: true).accounts =
          await _accountsService.getAccountsForUser(phone);

  Future<void> _getMetaByPhone(String phone, BuildContext context) async =>
      ScopedModel.of<ActiveUser>(context, rebuildOnChange: true).meta =
          await _accountsService.getMetaForUser(phone);

  Future<void> _getTransactionsByPhone(
          String phone, BuildContext context) async =>
      ScopedModel.of<ActiveUser>(context, rebuildOnChange: true).transactions =
          await _transactionsService.getTransactionsByPhone(phone);

  Future<void> _getBudgetsByPhone(String phone, BuildContext context) async =>
      ScopedModel.of<ActiveUser>(context, rebuildOnChange: true).budgets =
          await _budgetsService.getBudgetsForUser(phone);
}
