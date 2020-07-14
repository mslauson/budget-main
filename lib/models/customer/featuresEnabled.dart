import 'package:json_annotation/json_annotation.dart';

part 'featuresEnabled.g.dart';

@JsonSerializable(nullable: false)
class FeaturesEnabled {
  @JsonKey(includeIfNull: false)
  final bool budgetEnabled;
  @JsonKey(includeIfNull: false)
  final bool paidFeatures;

  FeaturesEnabled(this.budgetEnabled, this.paidFeatures);

  factory FeaturesEnabled.fromJson(Map<String, dynamic> json) =>
      _$FeaturesEnabledFromJson(json);

  Map<String, dynamic> toJson() => _$FeaturesEnabledToJson(this);
}
