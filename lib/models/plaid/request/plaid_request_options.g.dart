// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plaid_request_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Options _$OptionsFromJson(Map<String, dynamic> json) {
  return Options(
    includeOptionalMetadata: json['include_optional_metadata'] as bool,
  );
}

Map<String, dynamic> _$OptionsToJson(Options instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('include_optional_metadata', instance.includeOptionalMetadata);
  return val;
}
