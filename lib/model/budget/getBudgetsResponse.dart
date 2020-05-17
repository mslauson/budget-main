class GetBudgetsResponse {
  List<Budgets> budgets;

  GetBudgetsResponse({this.budgets});

  GetBudgetsResponse.fromJson(Map<String, dynamic> json) {
    if (json['budgets'] != null) {
      budgets = new List<Budgets>();
      json['budgets'].forEach((v) {
        budgets.add(new Budgets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.budgets != null) {
      data['budgets'] = this.budgets.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Budgets {
  String id;
  String email;
  String dateCreated;
  String monthYear;
  String name;
  String category;
  List<SubCategory> subCategory;
  Null used;
  double allocation;
  bool visible;
  List<LinkedTransactions> linkedTransactions;

  Budgets(
      {this.id,
      this.email,
      this.dateCreated,
      this.monthYear,
      this.name,
      this.category,
      this.subCategory,
        this.used,
        this.allocation,
        this.visible,
        this.linkedTransactions});

  Budgets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    dateCreated = json['dateCreated'];
    monthYear = json['monthYear'];
    name = json['name'];
    category = json['category'];
    if (json['subCategory'] != null) {
      subCategory = new List<SubCategory>();
      json['subCategory'].forEach((v) {
        subCategory.add(new SubCategory.fromJson(v));
      });
    }
    used = json['used'];
    allocation = json['allocation'];
    visible = json['visible'];
    if (json['linkedTransactions'] != null) {
      linkedTransactions = new List<LinkedTransactions>();
      json['linkedTransactions'].forEach((v) {
        linkedTransactions.add(new LinkedTransactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['dateCreated'] = this.dateCreated;
    data['monthYear'] = this.monthYear;
    data['name'] = this.name;
    data['category'] = this.category;
    if (this.subCategory != null) {
      data['subCategory'] = this.subCategory.map((v) => v.toJson()).toList();
    }
    data['used'] = this.used;
    data['allocation'] = this.allocation;
    data['visible'] = this.visible;
    if (this.linkedTransactions != null) {
      data['linkedTransactions'] =
          this.linkedTransactions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategory {
  Null id;
  String name;
  String category;
  Null used;
  double allocation;
  bool visible;
  List<LinkedTransactions> linkedTransactions;

  SubCategory({this.id,
    this.name,
    this.category,
    this.used,
    this.allocation,
    this.visible,
        this.linkedTransactions});

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    used = json['used'];
    allocation = json['allocation'];
    visible = json['visible'];
    if (json['linkedTransactions'] != null) {
      linkedTransactions = new List<LinkedTransactions>();
      json['linkedTransactions'].forEach((v) {
        linkedTransactions.add(new LinkedTransactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category'] = this.category;
    data['used'] = this.used;
    data['allocation'] = this.allocation;
    data['visible'] = this.visible;
    if (this.linkedTransactions != null) {
      data['linkedTransactions'] =
          this.linkedTransactions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LinkedTransactions {
  String transactionId;
  double amount;

  LinkedTransactions({this.transactionId, this.amount});

  LinkedTransactions.fromJson(Map<String, dynamic> json) {
    transactionId = json['transactionId'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transactionId'] = this.transactionId;
    data['amount'] = this.amount;
    return data;
  }
}
