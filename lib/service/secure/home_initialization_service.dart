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
    await getAccountsByPhone(phone, context);
    await getMetaByPhone(phone, context);
    await getTransactionsByPhone(phone, context);
    await getBudgetsByPhone(phone, context);
  }

  Future<void> getAccountsByPhone(String phone, BuildContext context) async =>
      ScopedModel.of<ActiveUser>(context, rebuildOnChange: true).accounts =
          await _accountsService.getAccountsForUser(phone);

  Future<void> getMetaByPhone(String phone, BuildContext context) async =>
      ScopedModel.of<ActiveUser>(context, rebuildOnChange: true).meta =
          await _accountsService.getMetaForUser(phone);

  Future<void> getTransactionsByPhone(
          String phone, BuildContext context) async =>
      ScopedModel.of<ActiveUser>(context, rebuildOnChange: true).transactions =
          await _transactionsService.getTransactionsByPhone(phone);

  Future<void> getBudgetsByPhone(String phone, BuildContext context) async =>
      ScopedModel.of<ActiveUser>(context, rebuildOnChange: true).budgets =
          await _budgetsService.getBudgetsForUser(phone);
}
