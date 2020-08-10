// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plaid_token_exchange_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaidTokenExchangeRequest _$PlaidTokenExchangeRequestFromJson(
    Map<String, dynamic> json) {
  return PlaidTokenExchangeRequest(
    json['client_id'] as String,
    json['secret'] as String,
    json['public_token'] as String,
  );
}

Map<String, dynamic> _$PlaidTokenExchangeRequestToJson(
        PlaidTokenExchangeRequest instance) =>
    <String, dynamic>{
      'client_id': instance.clientId,
      'secret': instance.secret,
      'public_token': instance.publicToken,
    };
