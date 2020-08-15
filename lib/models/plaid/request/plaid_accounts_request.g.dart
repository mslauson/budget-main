// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plaid_accounts_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaidAccountsRequest _$PlaidAccountsRequestFromJson(Map<String, dynamic> json) {
  return PlaidAccountsRequest(
    clientId: json['client_id'] as String,
    secret: json['secret'] as String,
    accessToken: json['access_token'] as String,
  );
}

Map<String, dynamic> _$PlaidAccountsRequestToJson(
        PlaidAccountsRequest instance) =>
    <String, dynamic>{
      'client_id': instance.clientId,
      'secret': instance.secret,
      'access_token': instance.accessToken,
    };
