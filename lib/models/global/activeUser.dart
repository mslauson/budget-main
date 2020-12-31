import 'package:main/models/accounts/response/account_meta_response.dart';
import 'package:main/models/accounts/response/accounts_response.dart';
import 'package:main/models/budget/getBudgetsResponse.dart';
import 'package:main/models/transactions/transactions_get_response.dart';
import 'package:scoped_model/scoped_model.dart';

class ActiveUser extends Model {
  String phone;
  String lastLogin;
  TransactionsGetResponse transactions;
  GetBudgetsResponse budgets;
  AccountsResponseModel accounts;
  AccountMetaResponse meta;
}