import 'package:json_annotation/json_annotation.dart';
import 'package:main/models/accounts/accounts.dart';
import 'package:main/models/accounts/institution.dart';

part 'accounts_full_model.g.dart';

@JsonSerializable(includeIfNull: false)
class AccountsFullModel {
  @JsonKey(name: 'accounts')
  final List<Accounts> accounts;
  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'phone')
  final String phone;
  @JsonKey(name: 'lastUpdated')
  final String lastUpdated;
  @JsonKey(name: 'flaggedForDeletion')
  final bool flaggedForDeletion;
  @JsonKey(name: 'deletionTimeStamp')
  final String deletionTimeStamp;
  @JsonKey(name: 'linkSessionId')
  final String linkSessionId;
  @JsonKey(name: 'accessToken')
  final String accessToken;
  @JsonKey(name: 'institution')
  final Institution institution;
  @JsonKey(name: 'needsUpdating')
  final bool needsUpdating;

  AccountsFullModel(
      {this.accounts,
      this.id,
      this.phone,
      this.lastUpdated,
      this.flaggedForDeletion,
      this.deletionTimeStamp,
      this.linkSessionId,
      this.accessToken,
      this.institution,
      this.needsUpdating});

  factory AccountsFullModel.fromJson(Map<String, dynamic> json) =>
      _$AccountsFullModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccountsFullModelToJson(this);
}
