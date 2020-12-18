class DeleteAccountRequestModel {
  String phone;
  String accountId;

  DeleteAccountRequestModel({this.phone, this.accountId});

  DeleteAccountRequestModel.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    accountId = json['accountId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['accountId'] = this.accountId;
    return data;
  }
}
