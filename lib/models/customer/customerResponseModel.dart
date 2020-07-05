import 'package:json_annotation/json_annotation.dart';
import 'package:main/models/customer/featuresEnabled.dart';

part 'customerResponseModel.g.dart';

@JsonSerializable(nullable: false, explicitToJson: true)
class CustomerResponseModel {
  final String emailAddress;
  final String firstName;
  @JsonKey(includeIfNull: false)
  final String middleName;
  final String lastName;
  @JsonKey(includeIfNull: false)
  final String addressOne;
  @JsonKey(includeIfNull: false)
  final String addressTwo;
  @JsonKey(includeIfNull: false)
  final String city;
  @JsonKey(includeIfNull: false)
  final String state;
  @JsonKey(includeIfNull: false)
  final String zipCode;
  final BigInt phone;
  final DateTime lastLogin;
  final FeaturesEnabled featuresEnabled;

  CustomerResponseModel(
      this.emailAddress,
      this.firstName,
      this.middleName,
      this.lastName,
      this.addressOne,
      this.addressTwo,
      this.city,
      this.state,
      this.zipCode,
      this.phone,
      this.lastLogin,
      this.featuresEnabled);

  factory CustomerResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerResponseModelToJson(this);
}
