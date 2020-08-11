// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_token_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinkTokenRequest _$LinkTokenRequestFromJson(Map<String, dynamic> json) {
  return LinkTokenRequest(
    json['client_id'] as String,
    json['secret'] as String,
    json['client_name'] as String,
    json['language'] as String,
    json['country_codes'] as List,
    PlaidUser.fromJson(json['user'] as Map<String, dynamic>),
    json['products'] as List,
    json['webhook'] as String,
    json['link_customization_name'] as String,
    json['access_token'] as String,
  );
}

Map<String, dynamic> _$LinkTokenRequestToJson(LinkTokenRequest instance) =>
    <String, dynamic>{
      'client_id': instance.clientId,
      'secret': instance.secret,
      'client_name': instance.clientName,
      'language': instance.language,
      'country_codes': instance.countryCodes,
      'user': instance.user,
      'products': instance.products,
      'webhook': instance.webHook,
      'link_customization_name': instance.linkCustomizationName,
      'access_token': instance.accessToken,
    };
