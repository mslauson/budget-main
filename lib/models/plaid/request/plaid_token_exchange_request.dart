import 'package:json_annotation/json_annotation.dart';

part 'plaid_token_exchange_request.g.dart';

@JsonSerializable(nullable: false)
class PlaidTokenExchangeRequest {
  @JsonKey(name: 'client_id')
  final String clientId;
  @JsonKey(name: 'secret')
  final String secret;
  @JsonKey(name: 'public_token')
  final String publicToken;

  PlaidTokenExchangeRequest({this.clientId, this.secret, this.publicToken});

  factory PlaidTokenExchangeRequest.fromJson(Map<String, dynamic> json) =>
      _$PlaidTokenExchangeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PlaidTokenExchangeRequestToJson(this);
}
