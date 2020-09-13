import 'package:json_annotation/json_annotation.dart';
import 'package:main/models/accounts/account.dart';

part 'plaid_accounts_response.g.dart';

@JsonSerializable()
class PlaidAccountsResponse {
  @JsonKey(name: 'accounts')
  final List<Account> accounts;

  PlaidAccountsResponse({this.accounts});

  factory PlaidAccountsResponse.fromJson(Map<String, dynamic> json) =>
      _$PlaidAccountsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PlaidAccountsResponseToJson(this);
}
