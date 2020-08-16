// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plaid_accounts_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaidAccountsResponse _$PlaidAccountsResponseFromJson(
    Map<String, dynamic> json) {
  return PlaidAccountsResponse(
    accounts: (json['accounts'] as List)
        ?.map((e) =>
            e == null ? null : Accounts.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PlaidAccountsResponseToJson(
        PlaidAccountsResponse instance) =>
    <String, dynamic>{
      'accounts': instance.accounts,
    };
