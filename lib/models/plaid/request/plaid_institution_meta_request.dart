import 'package:json_annotation/json_annotation.dart';
import 'package:main/models/plaid/request/plaid_request_options.dart';

part 'plaid_institution_meta_request.g.dart';

@JsonSerializable()
class PlaidInstitutionMetaRequest {
  @JsonKey(name: 'institution_id')
  final String institutionId;
  @JsonKey(name: 'client_id')
  final String clientId;
  @JsonKey(name: 'secret')
  final String secret;
  @JsonKey(name: 'options')
  final Options options;

  PlaidInstitutionMetaRequest(
      {this.institutionId, this.clientId, this.secret, this.options});

  factory PlaidInstitutionMetaRequest.fromJson(Map<String, dynamic> json) =>
      _$PlaidInstitutionMetaRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PlaidInstitutionMetaRequestToJson(this);
}
