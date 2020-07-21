// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'featuresEnabled.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeaturesEnabled _$FeaturesEnabledFromJson(Map<String, dynamic> json) {
  return FeaturesEnabled(
    json['budgetEnabled'] as bool,
    json['paidFeatures'] as bool,
  );
}

Map<String, dynamic> _$FeaturesEnabledToJson(FeaturesEnabled instance) =>
    <String, dynamic>{
      'budgetEnabled': instance.budgetEnabled,
      'paidFeatures': instance.paidFeatures,
    };
