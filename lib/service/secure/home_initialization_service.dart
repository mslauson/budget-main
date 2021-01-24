import 'package:flutter/cupertino.dart';
import 'package:main/models/accounts/response/account_meta_response.dart';
import 'package:main/models/accounts/response/accounts_response.dart';
import 'package:main/models/budget/getBudgetsResponse.dart';
import 'package:main/models/global/activeUser.dart';
import 'package:main/models/transactions/transactions_get_response.dart';
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

  Future<void> getAccountsByPhone(String phone, BuildContext context) async {
    AccountsResponseModel fullModel =
        await _accountsService.getAccountsForUser(phone);
    if (fullModel != null) {
      ScopedModel.of<ActiveUser>(context, rebuildOnChange: true).accounts =
          fullModel;
    }
  }

  Future<void> getMetaByPhone(String phone, BuildContext context) async {
    AccountMetaResponse metaResponse =
        await _accountsService.getMetaForUser(phone);
    if (metaResponse != null) {
      ScopedModel.of<ActiveUser>(context, rebuildOnChange: true).meta =
          metaResponse;
    }
  }

  Future<void> getTransactionsByPhone(
      String phone, BuildContext context) async {
    TransactionsGetResponse transactionsGetResponse =
        await _transactionsService.getTransactionsByPhone(phone);
    if (transactionsGetResponse != null) {
      ScopedModel.of<ActiveUser>(context, rebuildOnChange: true).transactions =
          transactionsGetResponse;
    }
  }

  Future<void> getBudgetsByPhone(String phone, BuildContext context) async {
    GetBudgetsResponse getBudgetsResponse =
        await _budgetsService.getBudgetsForUser(phone);
    if (getBudgetsResponse != null) {
      ScopedModel.of<ActiveUser>(context, rebuildOnChange: true).budgets =
          getBudgetsResponse;
    }
  }
}
