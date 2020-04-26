class GetAccountsResponse {
  List<ItemList> itemList;

  GetAccountsResponse({this.itemList});

  GetAccountsResponse.fromJson(Map<String, dynamic> json) {
    if (json['itemList'] != null) {
      itemList = new List<ItemList>();
      json['itemList'].forEach((v) {
        itemList.add(new ItemList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.itemList != null) {
      data['itemList'] = this.itemList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemList {
  ItemStatus itemStatus;
  List<Accounts> accounts;
  String id;
  String email;
  String lastUpdated;
  bool flaggedForDeletion;
  String deletionTimeStamp;
  String linkSessionId;
  String accessToken;
  Institution institution;
  bool needsUpdating;

  ItemList(
      {this.itemStatus,
        this.accounts,
        this.id,
        this.email,
        this.lastUpdated,
        this.flaggedForDeletion,
        this.deletionTimeStamp,
        this.linkSessionId,
        this.accessToken,
        this.institution,
        this.needsUpdating});

  ItemList.fromJson(Map<String, dynamic> json) {
    itemStatus = json['itemStatus'] != null
        ? new ItemStatus.fromJson(json['itemStatus'])
        : null;
    if (json['accounts'] != null) {
      accounts = new List<Accounts>();
      json['accounts'].forEach((v) {
        accounts.add(new Accounts.fromJson(v));
      });
    }
    id = json['id'];
    email = json['email'];
    lastUpdated = json['lastUpdated'];
    flaggedForDeletion = json['flaggedForDeletion'];
    deletionTimeStamp = json['deletionTimeStamp'];
    linkSessionId = json['linkSessionId'];
    accessToken = json['accessToken'];
    institution = json['institution'] != null
        ? new Institution.fromJson(json['institution'])
        : null;
    needsUpdating = json['needsUpdating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.itemStatus != null) {
      data['itemStatus'] = this.itemStatus.toJson();
    }
    if (this.accounts != null) {
      data['accounts'] = this.accounts.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['email'] = this.email;
    data['lastUpdated'] = this.lastUpdated;
    data['flaggedForDeletion'] = this.flaggedForDeletion;
    data['deletionTimeStamp'] = this.deletionTimeStamp;
    data['linkSessionId'] = this.linkSessionId;
    data['accessToken'] = this.accessToken;
    if (this.institution != null) {
      data['institution'] = this.institution.toJson();
    }
    data['needsUpdating'] = this.needsUpdating;
    return data;
  }
}

class ItemStatus {
  List<String> availableProducts;
  List<String> billedProducts;
  String institutionId;
  String itemId;
  String webhook;
  String consentExpirationTime;

  ItemStatus(
      {this.availableProducts,
        this.billedProducts,
        this.institutionId,
        this.itemId,
        this.webhook,
        this.consentExpirationTime});

  ItemStatus.fromJson(Map<String, dynamic> json) {
    availableProducts = json['availableProducts'].cast<String>();
    billedProducts = json['billedProducts'].cast<String>();
    institutionId = json['institutionId'];
    itemId = json['itemId'];
    webhook = json['webhook'];
    consentExpirationTime = json['consentExpirationTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['availableProducts'] = this.availableProducts;
    data['billedProducts'] = this.billedProducts;
    data['institutionId'] = this.institutionId;
    data['itemId'] = this.itemId;
    data['webhook'] = this.webhook;
    data['consentExpirationTime'] = this.consentExpirationTime;
    return data;
  }
}

class Accounts {
  String id;
  String name;
  String mask;
  String type;
  String subtype;
  Balances balances;
  String verificationStatus;

  Accounts(
      {this.id,
        this.name,
        this.mask,
        this.type,
        this.subtype,
        this.balances,
        this.verificationStatus});

  Accounts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mask = json['mask'];
    type = json['type'];
    subtype = json['subtype'];
    balances = json['balances'] != null
        ? new Balances.fromJson(json['balances'])
        : null;
    verificationStatus = json['verificationStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mask'] = this.mask;
    data['type'] = this.type;
    data['subtype'] = this.subtype;
    if (this.balances != null) {
      data['balances'] = this.balances.toJson();
    }
    data['verificationStatus'] = this.verificationStatus;
    return data;
  }
}

class Balances {
  double available;
  double current;
  String isoCurrencyCode;
  String unofficialCurrencyCode;

  Balances(
      {this.available,
        this.current,
        this.isoCurrencyCode,
        this.unofficialCurrencyCode});

  Balances.fromJson(Map<String, dynamic> json) {
    available = json['available'];
    current = json['current'];
    isoCurrencyCode = json['isoCurrencyCode'];
    unofficialCurrencyCode = json['unofficialCurrencyCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['available'] = this.available;
    data['current'] = this.current;
    data['isoCurrencyCode'] = this.isoCurrencyCode;
    data['unofficialCurrencyCode'] = this.unofficialCurrencyCode;
    return data;
  }
}

class Institution {
  String institutionId;
  String name;

  Institution({this.institutionId, this.name});

  Institution.fromJson(Map<String, dynamic> json) {
    institutionId = json['institutionId'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['institutionId'] = this.institutionId;
    data['name'] = this.name;
    return data;
  }
}