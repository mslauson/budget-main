// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_token_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinkTokenResponse _$LinkTokenResponseFromJson(Map<String, dynamic> json) {
  return LinkTokenResponse(
    json['link_token'] as String,
    json['expiration'] as String,
    json['request_id'] as String,
  );
}

Map<String, dynamic> _$LinkTokenResponseToJson(LinkTokenResponse instance) =>
    <String, dynamic>{
      'link_token': instance.linkToken,
      'expiration': instance.expiration,
      'request_id': instance.requestId,
    };
