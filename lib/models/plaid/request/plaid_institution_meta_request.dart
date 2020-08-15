import 'package:json_annotation/json_annotation.dart';

part 'plaid_institution_meta_request.g.dart';

@JsonSerializable()
class PlaidInstitutionMetaRequest {
  @JsonKey(name: 'institution_id')
  final String institutionId;
  @JsonKey(name: 'client_id')
  final String clientId;
  @JsonKey(name: 'secret')
  final String secret;
  @JsonKey(name: 'include_optional_metadata')
  final bool includeOptionalMetadata;

  PlaidInstitutionMetaRequest(
      {this.institutionId,
      this.clientId,
      this.secret,
      this.includeOptionalMetadata});

  factory PlaidInstitutionMetaRequest.fromJson(Map<String, dynamic> json) =>
      _$PlaidInstitutionMetaRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PlaidInstitutionMetaRequestToJson(this);
}
