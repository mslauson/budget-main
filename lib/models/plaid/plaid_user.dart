import 'package:json_annotation/json_annotation.dart';

part 'plaid_user.g.dart';

@JsonSerializable(nullable: false)
class PlaidUser {
  @JsonKey(name: 'client_user_id')
  final String clientUserId;

  PlaidUser(this.clientUserId);

  factory PlaidUser.fromJson(Map<String, dynamic> json) =>
      _$PlaidUserFromJson(json);

  Map<String, dynamic> toJson() => _$PlaidUserToJson(this);
}
