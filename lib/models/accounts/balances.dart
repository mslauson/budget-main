import 'package:json_annotation/json_annotation.dart';

part 'balances.g.dart';

@JsonSerializable(includeIfNull: false)
class Balances {
  @JsonKey(name: 'available')
  final available;
  @JsonKey(name: 'current')
  final current;
  @JsonKey(name: 'iso_currency_code')
  final String isoCurrencyCode;
  @JsonKey(name: 'unofficial_currency_code')
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
