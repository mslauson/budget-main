import 'package:main/models/accounts/account_meta.dart';

class AccountMetaResponse {
  List<AccountMeta> accountMetaList;

  AccountMetaResponse({this.accountMetaList});

  AccountMetaResponse.fromJson(Map<String, dynamic> json) {
    if (json['accountMetaList'] != null) {
      accountMetaList = new List<AccountMeta>();
      json['accountMetaList'].forEach((v) {
        accountMetaList.add(new AccountMeta.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.accountMetaList != null) {
      data['accountMetaList'] =
          this.accountMetaList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
