import 'package:main/models/plaid/accounts.dart';
import 'package:main/models/plaid/item.dart';
import 'package:main/models/transactions/transactions.dart';

class PlaidTransactionsResponse {
  List<Accounts> accounts;
  List<Transactions> transactions;
  Item item;
  int totalTransactions;
  String requestId;

  PlaidTransactionsResponse(
      {this.accounts,
      this.transactions,
      this.item,
      this.totalTransactions,
      this.requestId});

  PlaidTransactionsResponse.fromJson(Map<String, dynamic> json) {
    if (json['accounts'] != null) {
      accounts = new List<Accounts>();
      json['accounts'].forEach((v) {
        accounts.add(new Accounts.fromJson(v));
      });
    }
    if (json['transactions'] != null) {
      transactions = new List<Transactions>();
      json['transactions'].forEach((v) {
        transactions.add(new Transactions.fromJson(v));
      });
    }
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
    totalTransactions = json['total_transactions'];
    requestId = json['request_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.accounts != null) {
      data['accounts'] = this.accounts.map((v) => v.toJson()).toList();
    }
    if (this.transactions != null) {
      data['transactions'] = this.transactions.map((v) => v.toJson()).toList();
    }
    if (this.item != null) {
      data['item'] = this.item.toJson();
    }
    data['total_transactions'] = this.totalTransactions;
    data['request_id'] = this.requestId;
    return data;
  }
}
