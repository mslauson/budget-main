// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plaid_institution_meta_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaidInstitutionMetaResponse _$PlaidInstitutionMetaResponseFromJson(
    Map<String, dynamic> json) {
  return PlaidInstitutionMetaResponse(
    url: json['url'] as String,
    primaryColor: json['primary_color'] as String,
    logo: json['logo'] as String,
  );
}

Map<String, dynamic> _$PlaidInstitutionMetaResponseToJson(
        PlaidInstitutionMetaResponse instance) =>
    <String, dynamic>{
      'url': instance.url,
      'primary_color': instance.primaryColor,
      'logo': instance.logo,
    };
