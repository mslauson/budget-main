import 'package:main/models/plaid/location.dart';
import 'package:main/models/plaid/payment_meta.dart';

class Transactions {
  String accountId;
  double amount;
  String isoCurrencyCode;
  Null unofficialCurrencyCode;
  List<String> category;
  String categoryId;
  String date;
  String authorizedDate;
  Location location;
  String name;
  String merchantName;
  PaymentMeta paymentMeta;
  String paymentChannel;
  bool pending;
  Null pendingTransactionId;
  Null accountOwner;
  String transactionId;
  Null transactionCode;
  String transactionType;

  Transactions(
      {this.accountId,
      this.amount,
      this.isoCurrencyCode,
      this.unofficialCurrencyCode,
      this.category,
      this.categoryId,
      this.date,
      this.authorizedDate,
      this.location,
      this.name,
      this.merchantName,
      this.paymentMeta,
      this.paymentChannel,
      this.pending,
      this.pendingTransactionId,
      this.accountOwner,
      this.transactionId,
      this.transactionCode,
      this.transactionType});

  Transactions.fromJson(Map<String, dynamic> json) {
    accountId = json['account_id'];
    amount = json['amount'];
    isoCurrencyCode = json['iso_currency_code'];
    unofficialCurrencyCode = json['unofficial_currency_code'];
    category = json['category'].cast<String>();
    categoryId = json['category_id'];
    date = json['date'];
    authorizedDate = json['authorized_date'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    name = json['name'];
    merchantName = json['merchant_name'];
    paymentMeta = json['payment_meta'] != null
        ? new PaymentMeta.fromJson(json['payment_meta'])
        : null;
    paymentChannel = json['payment_channel'];
    pending = json['pending'];
    pendingTransactionId = json['pending_transaction_id'];
    accountOwner = json['account_owner'];
    transactionId = json['transaction_id'];
    transactionCode = json['transaction_code'];
    transactionType = json['transaction_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_id'] = this.accountId;
    data['amount'] = this.amount;
    data['iso_currency_code'] = this.isoCurrencyCode;
    data['unofficial_currency_code'] = this.unofficialCurrencyCode;
    data['category'] = this.category;
    data['category_id'] = this.categoryId;
    data['date'] = this.date;
    data['authorized_date'] = this.authorizedDate;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['name'] = this.name;
    data['merchant_name'] = this.merchantName;
    if (this.paymentMeta != null) {
      data['payment_meta'] = this.paymentMeta.toJson();
    }
    data['payment_channel'] = this.paymentChannel;
    data['pending'] = this.pending;
    data['pending_transaction_id'] = this.pendingTransactionId;
    data['account_owner'] = this.accountOwner;
    data['transaction_id'] = this.transactionId;
    data['transaction_code'] = this.transactionCode;
    data['transaction_type'] = this.transactionType;
    return data;
  }
}
