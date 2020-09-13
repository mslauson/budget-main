import 'package:json_annotation/json_annotation.dart';

import 'balances.dart';

part 'account.g.dart';

@JsonSerializable(includeIfNull: false)
class Account {
  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'account_id')
  final String accountId;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'mask')
  final String mask;
  @JsonKey(name: 'type')
  final String type;
  @JsonKey(name: 'subtype')
  final String subtype;
  @JsonKey(name: 'balances')
  final Balances balances;
  @JsonKey(name: 'verificationStatus')
  final String verificationStatus;

  Account(
      {this.id,
      this.accountId,
      this.name,
      this.mask,
      this.type,
      this.subtype,
      this.balances,
      this.verificationStatus});

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountsFromJson(json);

  Map<String, dynamic> toJson() => _$AccountsToJson(this);
}
