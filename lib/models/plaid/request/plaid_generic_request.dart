import 'package:json_annotation/json_annotation.dart';

part 'plaid_generic_request.g.dart';

@JsonSerializable()
class PlaidGenericRequest {
  @JsonKey(name: 'client_id')
  final String clientId;
  @JsonKey(name: 'secret')
  final String secret;
  @JsonKey(name: 'access_token')
  final String accessToken;

  PlaidGenericRequest({this.clientId, this.secret, this.accessToken});

  factory PlaidGenericRequest.fromJson(Map<String, dynamic> json) =>
      _$PlaidAccountsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PlaidAccountsRequestToJson(this);
}
