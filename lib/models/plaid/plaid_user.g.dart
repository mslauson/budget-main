// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plaid_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaidUser _$PlaidUserFromJson(Map<String, dynamic> json) {
  return PlaidUser(
    clientUserId: json['client_user_id'] as String,
  );
}

Map<String, dynamic> _$PlaidUserToJson(PlaidUser instance) => <String, dynamic>{
      'client_user_id': instance.clientUserId,
    };
