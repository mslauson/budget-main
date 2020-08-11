// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_token_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinkTokenRequest _$LinkTokenRequestFromJson(Map<String, dynamic> json) {
  return LinkTokenRequest(
    clientId: json['client_id'] as String,
    secret: json['secret'] as String,
    clientName: json['client_name'] as String,
    language: json['language'] as String,
    countryCodes: json['country_codes'] as List,
    user: PlaidUser.fromJson(json['user'] as Map<String, dynamic>),
    products: json['products'] as List,
    webHook: json['webhook'] as String,
    linkCustomizationName: json['link_customization_name'] as String,
    accessToken: json['access_token'] as String,
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
