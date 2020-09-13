import 'package:json_annotation/json_annotation.dart';

part 'link_token_response.g.dart';

@JsonSerializable(nullable: false)
class LinkTokenResponse {
  @JsonKey(name: 'link_token')
  final String linkToken;
  @JsonKey(name: 'expiration')
  final String expiration;
  @JsonKey(name: 'request_id')
  final String requestId;

  LinkTokenResponse(this.linkToken, this.expiration, this.requestId);

  factory LinkTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$LinkTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LinkTokenResponseToJson(this);
}
