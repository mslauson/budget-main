import 'package:json_annotation/json_annotation.dart';

part 'plaid_request_options.g.dart';

@JsonSerializable(includeIfNull: false)
class Options {
  @JsonKey(name: 'include_optional_metadata')
  final bool includeOptionalMetadata;

  Options({this.includeOptionalMetadata});

  factory Options.fromJson(Map<String, dynamic> json) =>
      _$OptionsFromJson(json);

  Map<String, dynamic> toJson() => _$OptionsToJson(this);
}
