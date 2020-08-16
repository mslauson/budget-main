// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Error _$ErrorFromJson(Map<String, dynamic> json) {
  return Error(
    requestId: json['requestId'] as String,
    displayMessage: json['displayMessage'] as String,
    errorCode: json['errorCode'] as String,
    errorMessage: json['errorMessage'] as String,
    errorType: json['errorType'] as String,
  );
}

Map<String, dynamic> _$ErrorToJson(Error instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('requestId', instance.requestId);
  writeNotNull('displayMessage', instance.displayMessage);
  writeNotNull('errorCode', instance.errorCode);
  writeNotNull('errorMessage', instance.errorMessage);
  writeNotNull('errorType', instance.errorType);
  return val;
}
