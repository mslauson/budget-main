// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customerResponseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerResponseModel _$CustomerResponseModelFromJson(
    Map<String, dynamic> json) {
  return CustomerResponseModel(
    json['emailAddress'] as String,
    json['firstName'] as String,
    json['middleName'] as String,
    json['lastName'] as String,
    json['addressOne'] as String,
    json['addressTwo'] as String,
    json['city'] as String,
    json['state'] as String,
    json['zipCode'] as String,
    BigInt.parse(json['phone'] as String),
    DateTime.parse(json['lastLogin'] as String),
    FeaturesEnabled.fromJson(json['featuresEnabled'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CustomerResponseModelToJson(
        CustomerResponseModel instance) =>
    <String, dynamic>{
      'emailAddress': instance.emailAddress,
      'firstName': instance.firstName,
      'middleName': instance.middleName,
      'lastName': instance.lastName,
      'addressOne': instance.addressOne,
      'addressTwo': instance.addressTwo,
      'city': instance.city,
      'state': instance.state,
      'zipCode': instance.zipCode,
      'phone': instance.phone.toString(),
      'lastLogin': instance.lastLogin.toIso8601String(),
      'featuresEnabled': instance.featuresEnabled.toJson(),
    };
