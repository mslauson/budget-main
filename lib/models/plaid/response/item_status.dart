import 'package:main/models/plaid/response/plaid_item_transaction_response.dart';

import 'last_webhook.dart';

class ItemStatus {
  PlaidItemTransactionResponse transactions;
  LastWebhook lastWebhook;

  ItemStatus({this.transactions, this.lastWebhook});

  ItemStatus.fromJson(Map<String, dynamic> json) {
    transactions = json['transactions'] != null
        ? new PlaidItemTransactionResponse.fromJson(json['transactions'])
        : null;
    lastWebhook = json['last_webhook'] != null
        ? new LastWebhook.fromJson(json['last_webhook'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.transactions != null) {
      data['transactions'] = this.transactions.toJson();
    }
    if (this.lastWebhook != null) {
      data['last_webhook'] = this.lastWebhook.toJson();
    }
    return data;
  }
}
