class TransactionsGetResponse {
  List<Transactions> transactions;

  TransactionsGetResponse({this.transactions});

  TransactionsGetResponse.fromJson(Map<String, dynamic> json) {
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

class Transactions {
  String transactionId;
  String pendingTransactionId;
  String transacionType;
  String userName;
  String accountId;
  double amount;
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
        this.userName,
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
    userName = json['userName'];
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
    data['userName'] = this.userName;
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

class Location {
  String address;
  String city;
  double lat;
  double lon;
  String region;
  String storeNumber;
  String postalCode;
  String country;

  Location(
      {this.address,
      this.city,
      this.lat,
      this.lon,
      this.region,
        this.storeNumber,
        this.postalCode,
        this.country});

  Location.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    city = json['city'];
    lat = json['lat'];
    lon = json['lon'];
    region = json['region'];
    storeNumber = json['storeNumber'];
    postalCode = json['postalCode'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['city'] = this.city;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['region'] = this.region;
    data['storeNumber'] = this.storeNumber;
    data['postalCode'] = this.postalCode;
    data['country'] = this.country;
    return data;
  }
}

class PaymentMeta {
  String byOrderOf;
  String payee;
  String payer;
  String paymentMethod;
  String paymentProcessor;
  String ppdId;
  String reason;
  String referenceNumber;

  PaymentMeta(
      {this.byOrderOf,
        this.payee,
        this.payer,
        this.paymentMethod,
        this.paymentProcessor,
        this.ppdId,
        this.reason,
        this.referenceNumber});

  PaymentMeta.fromJson(Map<String, dynamic> json) {
    byOrderOf = json['byOrderOf'];
    payee = json['payee'];
    payer = json['payer'];
    paymentMethod = json['paymentMethod'];
    paymentProcessor = json['paymentProcessor'];
    ppdId = json['ppdId'];
    reason = json['reason'];
    referenceNumber = json['referenceNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['byOrderOf'] = this.byOrderOf;
    data['payee'] = this.payee;
    data['payer'] = this.payer;
    data['paymentMethod'] = this.paymentMethod;
    data['paymentProcessor'] = this.paymentProcessor;
    data['ppdId'] = this.ppdId;
    data['reason'] = this.reason;
    data['referenceNumber'] = this.referenceNumber;
    return data;
  }
}

class Reimbursement {
  bool reimbursed;
  double amount;
  List<String> linkedTransactions;

  Reimbursement({this.reimbursed, this.amount, this.linkedTransactions});

  Reimbursement.fromJson(Map<String, dynamic> json) {
    reimbursed = json['reimbursed'];
    amount = json['amount'];
    linkedTransactions = json['linkedTransactions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reimbursed'] = this.reimbursed;
    data['amount'] = this.amount;
    data['linkedTransactions'] = this.linkedTransactions;
    return data;
  }
}