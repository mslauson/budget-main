import 'balances.dart';

class Accounts {
  String accountId;
  Balances balances;
  String mask;
  String name;
  String officialName;
  String subtype;
  String type;

  Accounts(
      {this.accountId,
      this.balances,
      this.mask,
      this.name,
      this.officialName,
      this.subtype,
      this.type});

  Accounts.fromJson(Map<String, dynamic> json) {
    accountId = json['account_id'];
    balances = json['balances'] != null
        ? new Balances.fromJson(json['balances'])
        : null;
    mask = json['mask'];
    name = json['name'];
    officialName = json['official_name'];
    subtype = json['subtype'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_id'] = this.accountId;
    if (this.balances != null) {
      data['balances'] = this.balances.toJson();
    }
    data['mask'] = this.mask;
    data['name'] = this.name;
    data['official_name'] = this.officialName;
    data['subtype'] = this.subtype;
    data['type'] = this.type;
    return data;
  }
}
