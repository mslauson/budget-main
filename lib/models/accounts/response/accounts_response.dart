import 'package:main/models/accounts/accounts_full_model.dart';

class AccountsResponseModel {
  List<AccountsFullModel> itemList;

  AccountsResponseModel({this.itemList});

  AccountsResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['itemList'] != null) {
      itemList = new List<AccountsFullModel>();
      json['itemList'].forEach((v) {
        itemList.add(new AccountsFullModel.fromJson(v));
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
