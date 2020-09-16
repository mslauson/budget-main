import 'package:main/models/transactions/location.dart';
import 'package:main/models/transactions/payment_meta.dart';
import 'package:main/models/transactions/reimbursement.dart';

class Transactions {
  String transactionId;
  String pendingTransactionId;
  String transacionType;
  String phone;
  String accountId;
  int amount;
  String date;
  String authorizationDate;
  String merchant;
  bool isPending;
  String isoCurrencyCode;
  List<String> categories;
  String categoryId;
  Location location;
  PaymentMeta paymentMeta;
  Reimbursement reimbursement;
  String tags;
  String budgetId;
  String notes;
  String creationTimeStamp;
  String lastUpdated;
  bool flaggedForDeletion;
  String deletionTimeStamp;

  Transactions(
      {this.transactionId,
      this.pendingTransactionId,
      this.transacionType,
      this.phone,
      this.accountId,
      this.amount,
      this.date,
      this.authorizationDate,
      this.merchant,
      this.isPending,
      this.isoCurrencyCode,
      this.categories,
      this.categoryId,
      this.location,
      this.paymentMeta,
      this.reimbursement,
      this.tags,
      this.budgetId,
      this.notes,
      this.creationTimeStamp,
      this.lastUpdated,
      this.flaggedForDeletion,
      this.deletionTimeStamp});

  Transactions.fromJson(Map<String, dynamic> json) {
    transactionId = json['transactionId'];
    pendingTransactionId = json['pendingTransactionId'];
    transacionType = json['transacionType'];
    phone = json['phone'];
    accountId = json['accountId'];
    amount = json['amount'];
    date = json['date'];
    authorizationDate = json['authorizationDate'];
    merchant = json['merchant'];
    isPending = json['isPending'];
    isoCurrencyCode = json['isoCurrencyCode'];
    categories = json['categories'].cast<String>();
    categoryId = json['categoryId'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    paymentMeta = json['paymentMeta'] != null
        ? new PaymentMeta.fromJson(json['paymentMeta'])
        : null;
    reimbursement = json['reimbursement'] != null
        ? new Reimbursement.fromJson(json['reimbursement'])
        : null;
    tags = json['tags'];
    budgetId = json['budgetId'];
    notes = json['notes'];
    creationTimeStamp = json['creationTimeStamp'];
    lastUpdated = json['lastUpdated'];
    flaggedForDeletion = json['flaggedForDeletion'];
    deletionTimeStamp = json['deletionTimeStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transactionId'] = this.transactionId;
    data['pendingTransactionId'] = this.pendingTransactionId;
    data['transacionType'] = this.transacionType;
    data['phone'] = this.phone;
    data['accountId'] = this.accountId;
    data['amount'] = this.amount;
    data['date'] = this.date;
    data['authorizationDate'] = this.authorizationDate;
    data['merchant'] = this.merchant;
    data['isPending'] = this.isPending;
    data['isoCurrencyCode'] = this.isoCurrencyCode;
    data['categories'] = this.categories;
    data['categoryId'] = this.categoryId;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    if (this.paymentMeta != null) {
      data['paymentMeta'] = this.paymentMeta.toJson();
    }
    if (this.reimbursement != null) {
      data['reimbursement'] = this.reimbursement.toJson();
    }
    data['tags'] = this.tags;
    data['budgetId'] = this.budgetId;
    data['notes'] = this.notes;
    data['creationTimeStamp'] = this.creationTimeStamp;
    data['lastUpdated'] = this.lastUpdated;
    data['flaggedForDeletion'] = this.flaggedForDeletion;
    data['deletionTimeStamp'] = this.deletionTimeStamp;
    return data;
  }
}
