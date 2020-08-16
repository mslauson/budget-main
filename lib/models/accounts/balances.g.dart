// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balances.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Balances _$BalancesFromJson(Map<String, dynamic> json) {
  return Balances(
    available: json['available'] as double,
    current: json['current'],
    isoCurrencyCode: json['isoCurrencyCode'] as String,
    unofficialCurrencyCode: json['unofficialCurrencyCode'] as String,
  );
}

Map<String, dynamic> _$BalancesToJson(Balances instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('available', instance.available);
  writeNotNull('current', instance.current);
  writeNotNull('isoCurrencyCode', instance.isoCurrencyCode);
  writeNotNull('unofficialCurrencyCode', instance.unofficialCurrencyCode);
  return val;
}
