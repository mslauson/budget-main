// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountsFromJson(Map<String, dynamic> json) {
  return Account(
    id: json['id'] as String,
    accountId: json['account_id'] as String,
    name: json['name'] as String,
    mask: json['mask'] as String,
    type: json['type'] as String,
    subtype: json['subtype'] as String,
    balances: json['balances'] == null
        ? null
        : Balances.fromJson(json['balances'] as Map<String, dynamic>),
    verificationStatus: json['verificationStatus'] as String,
  );
}

Map<String, dynamic> _$AccountsToJson(Account instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('account_id', instance.accountId);
  writeNotNull('name', instance.name);
  writeNotNull('mask', instance.mask);
  writeNotNull('type', instance.type);
  writeNotNull('subtype', instance.subtype);
  writeNotNull('balances', instance.balances);
  writeNotNull('verificationStatus', instance.verificationStatus);
  return val;
}
