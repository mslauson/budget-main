import 'package:json_annotation/json_annotation.dart';

part 'plaid_token_exchange_response.g.dart';

@JsonSerializable(nullable: false)
class PlaidTokenExchangeResponse {
  @JsonKey(name: 'access_token')
  final String accessToken;
  @JsonKey(includeIfNull: false, name: 'item_id')
  final String itemId;
  @JsonKey(includeIfNull: false, name: 'request_id')
  final String requestId;

  PlaidTokenExchangeResponse(this.accessToken, this.itemId, this.requestId);

  factory PlaidTokenExchangeResponse.fromJson(Map<String, dynamic> json) =>
      _$PlaidTokenExchangeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PlaidTokenExchangeResponseToJson(this);
}
