import 'package:json_annotation/json_annotation.dart';

import 'balances.dart';

part 'accounts.g.dart';

@JsonSerializable(includeIfNull: false)
class Accounts {
  @JsonKey(name: 'id')
  final String id;
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

  Accounts(
      {this.id,
      this.name,
      this.mask,
      this.type,
      this.subtype,
      this.balances,
      this.verificationStatus});

  factory Accounts.fromJson(Map<String, dynamic> json) =>
      _$AccountsFromJson(json);

  Map<String, dynamic> toJson() => _$AccountsToJson(this);
}
