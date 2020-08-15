import 'package:json_annotation/json_annotation.dart';

part 'balances.g.dart';

@JsonSerializable(includeIfNull: false)
class Balances {
  @JsonKey(name: 'available')
  final double available;
  @JsonKey(name: 'current')
  final current;
  @JsonKey(name: 'isoCurrencyCode')
  final String isoCurrencyCode;
  @JsonKey(name: 'unofficialCurrencyCode')
  final String unofficialCurrencyCode;

  Balances(
      {this.available,
      this.current,
      this.isoCurrencyCode,
      this.unofficialCurrencyCode});

  factory Balances.fromJson(Map<String, dynamic> json) =>
      _$BalancesFromJson(json);

  Map<String, dynamic> toJson() => _$BalancesToJson(this);
}
