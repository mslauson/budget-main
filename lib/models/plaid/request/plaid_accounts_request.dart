import 'package:json_annotation/json_annotation.dart';

part 'plaid_accounts_request.g.dart';

@JsonSerializable()
class PlaidAccountsRequest {
  @JsonKey(name: 'client_id')
  final String clientId;
  @JsonKey(name: 'secret')
  final String secret;
  @JsonKey(name: 'access_token')
  final String accessToken;

  PlaidAccountsRequest(this.clientId, this.secret, this.accessToken);

  factory PlaidAccountsRequest.fromJson(Map<String, dynamic> json) =>
      _$PlaidAccountsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PlaidAccountsRequestToJson(this);
}
