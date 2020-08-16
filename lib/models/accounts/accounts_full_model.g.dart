// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts_full_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountsFullModel _$AccountsFullModelFromJson(Map<String, dynamic> json) {
  return AccountsFullModel(
    itemStatus: json['itemStatus'] == null
        ? null
        : ItemStatus.fromJson(json['itemStatus'] as Map<String, dynamic>),
    accounts: (json['accounts'] as List)
        ?.map((e) =>
            e == null ? null : Accounts.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    id: json['id'] as String,
    phone: json['phone'] as String,
    lastUpdated: json['lastUpdated'] as String,
    flaggedForDeletion: json['flaggedForDeletion'] as bool,
    deletionTimeStamp: json['deletionTimeStamp'] as String,
    linkSessionId: json['linkSessionId'] as String,
    accessToken: json['accessToken'] as String,
    institution: json['institution'] == null
        ? null
        : Institution.fromJson(json['institution'] as Map<String, dynamic>),
    needsUpdating: json['needsUpdating'] as bool,
  );
}

Map<String, dynamic> _$AccountsFullModelToJson(AccountsFullModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('itemStatus', instance.itemStatus);
  writeNotNull('accounts', instance.accounts);
  writeNotNull('id', instance.id);
  writeNotNull('phone', instance.phone);
  writeNotNull('lastUpdated', instance.lastUpdated);
  writeNotNull('flaggedForDeletion', instance.flaggedForDeletion);
  writeNotNull('deletionTimeStamp', instance.deletionTimeStamp);
  writeNotNull('linkSessionId', instance.linkSessionId);
  writeNotNull('accessToken', instance.accessToken);
  writeNotNull('institution', instance.institution);
  writeNotNull('needsUpdating', instance.needsUpdating);
  return val;
}
