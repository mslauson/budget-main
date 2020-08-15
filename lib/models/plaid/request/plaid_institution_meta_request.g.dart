// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plaid_institution_meta_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaidInstitutionMetaRequest _$PlaidInstitutionMetaRequestFromJson(
    Map<String, dynamic> json) {
  return PlaidInstitutionMetaRequest(
    institutionId: json['institution_id'] as String,
    clientId: json['client_id'] as String,
    secret: json['secret'] as String,
    includeOptionalMetadata: json['include_optional_metadata'] as bool,
  );
}

Map<String, dynamic> _$PlaidInstitutionMetaRequestToJson(
        PlaidInstitutionMetaRequest instance) =>
    <String, dynamic>{
      'institution_id': instance.institutionId,
      'client_id': instance.clientId,
      'secret': instance.secret,
      'include_optional_metadata': instance.includeOptionalMetadata,
    };
