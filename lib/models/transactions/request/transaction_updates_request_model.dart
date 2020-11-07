import 'package:main/models/transactions/request/transaction_updates.dart';

class TransactionUpdatesRequestModel {
  List<TransactionUpdates> transactionUpdates;

  TransactionUpdatesRequestModel({this.transactionUpdates});

  TransactionUpdatesRequestModel.fromJson(Map<String, dynamic> json) {
    if (json['transactionUpdates'] != null) {
      transactionUpdates = new List<TransactionUpdates>();
      json['transactionUpdates'].forEach((v) {
        transactionUpdates.add(new TransactionUpdates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.transactionUpdates != null) {
      data['transactionUpdates'] =
          this.transactionUpdates.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
