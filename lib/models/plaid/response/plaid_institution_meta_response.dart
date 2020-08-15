import 'package:json_annotation/json_annotation.dart';

part 'plaid_institution_meta_response.g.dart';

@JsonSerializable()
class PlaidInstitutionMetaResponse {
  @JsonKey(name: 'url')
  final String url;
  @JsonKey(name: 'primary_color')
  final String primaryColor;
  @JsonKey(name: 'logo')
  final String logo;

  PlaidInstitutionMetaResponse({this.url, this.primaryColor, this.logo});

  factory PlaidInstitutionMetaResponse.fromJson(Map<String, dynamic> json) =>
      _$PlaidInstitutionMetaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PlaidInstitutionMetaResponseToJson(this);
}
