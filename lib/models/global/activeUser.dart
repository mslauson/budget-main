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

  ActiveUser({this.phone, this.lastLogin});

  ActiveUser.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    lastLogin = json['lastLogin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['lastLogin'] = this.lastLogin;
    return data;
  }
}