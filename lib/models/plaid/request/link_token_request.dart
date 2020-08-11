import 'package:json_annotation/json_annotation.dart';
import 'package:main/models/plaid/plaid_user.dart';

part 'link_token_request.g.dart';

@JsonSerializable(nullable: false)
class LinkTokenRequest {
  @JsonKey(name: 'client_id')
  final String clientId;
  @JsonKey(name: 'secret')
  final String secret;
  @JsonKey(name: 'client_name')
  final String clientName;
  @JsonKey(name: 'language')
  final String language;
  @JsonKey(name: 'country_codes')
  final List countryCodes;
  @JsonKey(name: 'user')
  final PlaidUser user;
  @JsonKey(name: 'products')
  final List products;
  @JsonKey(name: 'webhook', includeIfNull: false)
  final String webHook;
  @JsonKey(name: 'link_customization_name', includeIfNull: false)
  final String linkCustomizationName;
  @JsonKey(name: 'access_token')
  final String accessToken;

  LinkTokenRequest(
      this.clientId,
      this.secret,
      this.clientName,
      this.language,
      this.countryCodes,
      this.user,
      this.products,
      this.webHook,
      this.linkCustomizationName,
      this.accessToken);

  factory LinkTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$LinkTokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LinkTokenRequestToJson(this);
}
