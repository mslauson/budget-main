import 'package:json_annotation/json_annotation.dart';

part 'error.g.dart';

@JsonSerializable(includeIfNull: false)
class Error {
  @JsonKey(name: 'requestId')
  final String requestId;
  @JsonKey(name: 'displayMessage')
  final String displayMessage;
  @JsonKey(name: 'errorCode')
  final String errorCode;
  @JsonKey(name: 'errorMessage')
  final String errorMessage;
  @JsonKey(name: 'errorType')
  final String errorType;

  Error(
      {this.requestId,
      this.displayMessage,
      this.errorCode,
      this.errorMessage,
      this.errorType});

  factory Error.fromJson(Map<String, dynamic> json) => _$ErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorToJson(this);
}
