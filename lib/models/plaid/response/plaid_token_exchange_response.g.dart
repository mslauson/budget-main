// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plaid_token_exchange_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaidTokenExchangeResponse _$PlaidTokenExchangeResponseFromJson(
    Map<String, dynamic> json) {
  return PlaidTokenExchangeResponse(
    json['access_token'] as String,
    json['item_id'] as String,
    json['request_id'] as String,
  );
}

Map<String, dynamic> _$PlaidTokenExchangeResponseToJson(
        PlaidTokenExchangeResponse instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'item_id': instance.itemId,
      'request_id': instance.requestId,
    };
