// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemStatus _$ItemStatusFromJson(Map<String, dynamic> json) {
  return ItemStatus(
    availableProducts:
        (json['availableProducts'] as List)?.map((e) => e as String)?.toList(),
    billedProducts:
        (json['billedProducts'] as List)?.map((e) => e as String)?.toList(),
    error: json['error'] == null
        ? null
        : Error.fromJson(json['error'] as Map<String, dynamic>),
    institutionId: json['institutionId'] as String,
    itemId: json['itemId'] as String,
    webhook: json['webhook'] as String,
    consentExpirationTime: json['consentExpirationTime'] as String,
  );
}

Map<String, dynamic> _$ItemStatusToJson(ItemStatus instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('availableProducts', instance.availableProducts);
  writeNotNull('billedProducts', instance.billedProducts);
  writeNotNull('error', instance.error);
  writeNotNull('institutionId', instance.institutionId);
  writeNotNull('itemId', instance.itemId);
  writeNotNull('webhook', instance.webhook);
  writeNotNull('consentExpirationTime', instance.consentExpirationTime);
  return val;
}
