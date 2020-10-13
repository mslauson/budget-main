class AccountMeta {
  String accountId;
  String accountName;
  String accountNumber;

  AccountMeta({this.accountId, this.accountName, this.accountNumber});

  AccountMeta.fromJson(Map<String, dynamic> json) {
    accountId = json['accountId'];
    accountName = json['accountName'];
    accountNumber = json['accountNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountId'] = this.accountId;
    data['accountName'] = this.accountName;
    data['accountNumber'] = this.accountNumber;
    return data;
  }
}
