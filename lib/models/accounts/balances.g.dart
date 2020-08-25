// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balances.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Balances _$BalancesFromJson(Map<String, dynamic> json) {
  return Balances(
    available: json['available'],
    current: json['current'],
    isoCurrencyCode: json['iso_currency_code'] as String,
    unofficialCurrencyCode: json['unofficial_currency_code'] as String,
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
