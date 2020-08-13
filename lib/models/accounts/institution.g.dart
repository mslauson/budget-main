// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'institution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Institution _$InstitutionFromJson(Map<String, dynamic> json) {
  return Institution(
    institutionId: json['institutionId'] as String,
    name: json['name'] as String,
    label: json['label'] as String,
    type: json['type'] as String,
    url: json['url'] as String,
    logo: json['logo'] as String,
    primaryColor: json['primaryColor'] as String,
  );
}

Map<String, dynamic> _$InstitutionToJson(Institution instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('institutionId', instance.institutionId);
  writeNotNull('name', instance.name);
  writeNotNull('label', instance.label);
  writeNotNull('type', instance.type);
  writeNotNull('url', instance.url);
  writeNotNull('logo', instance.logo);
  writeNotNull('primaryColor', instance.primaryColor);
  return val;
}
