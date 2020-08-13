import 'package:json_annotation/json_annotation.dart';

part 'institution.g.dart';

@JsonSerializable(includeIfNull: false)
class Institution {
  @JsonKey(name: 'institutionId')
  final String institutionId;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'label')
  final String label;
  @JsonKey(name: 'type')
  final String type;
  @JsonKey(name: 'url')
  final String url;
  @JsonKey(name: 'logo')
  final String logo;
  @JsonKey(name: 'primaryColor')
  final String primaryColor;

  Institution(
      {this.institutionId,
      this.name,
      this.label,
      this.type,
      this.url,
      this.logo,
      this.primaryColor});

  factory Institution.fromJson(Map<String, dynamic> json) =>
      _$InstitutionFromJson(json);

  Map<String, dynamic> toJson() => _$InstitutionToJson(this);
}
