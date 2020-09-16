import 'package:main/models/transactions/transactions.dart';

class TransactionsBatchRequest {
  List<Transactions> transactions;

  TransactionsBatchRequest({this.transactions});

  TransactionsBatchRequest.fromJson(Map<String, dynamic> json) {
    if (json['transactions'] != null) {
      transactions = new List<Transactions>();
      json['transactions'].forEach((v) {
        transactions.add(new Transactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.transactions != null) {
      data['transactions'] = this.transactions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
