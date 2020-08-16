import 'package:json_annotation/json_annotation.dart';
import 'package:main/models/accounts/error.dart';

part 'item_status.g.dart';

@JsonSerializable(includeIfNull: false)
class ItemStatus {
  @JsonKey(name: 'availableProducts')
  final List<String> availableProducts;
  @JsonKey(name: 'billedProducts')
  final List<String> billedProducts;
  @JsonKey(name: 'error')
  final Error error;
  @JsonKey(name: 'institutionId')
  final String institutionId;
  @JsonKey(name: 'itemId')
  final String itemId;
  @JsonKey(name: 'webhook')
  final String webhook;
  @JsonKey(name: 'consentExpirationTime')
  final String consentExpirationTime;

  ItemStatus(
      {this.availableProducts,
      this.billedProducts,
      this.error,
      this.institutionId,
      this.itemId,
      this.webhook,
      this.consentExpirationTime});

  factory ItemStatus.fromJson(Map<String, dynamic> json) =>
      _$ItemStatusFromJson(json);

  Map<String, dynamic> toJson() => _$ItemStatusToJson(this);
}
