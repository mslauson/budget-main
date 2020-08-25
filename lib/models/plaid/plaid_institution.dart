import 'package:main/models/plaid/plaid_credentials.dart';

class PlaidInstitution {
  List<String> countryCodes;
  List<PlaidCredentials> credentials;
  bool hasMfa;
  String inputSpec;
  String institutionId;
  String logo;
  List<String> mfa;
  String mfaCodeType;
  String name;
  bool oauth;
  String primaryColor;
  List<String> products;
  List<String> routingNumbers;
  String url;

  PlaidInstitution(
      {this.countryCodes,
      this.credentials,
      this.hasMfa,
      this.inputSpec,
      this.institutionId,
      this.logo,
      this.mfa,
      this.mfaCodeType,
      this.name,
      this.oauth,
      this.primaryColor,
      this.products,
      this.routingNumbers,
      this.url});

  PlaidInstitution.fromJson(Map<String, dynamic> json) {
    countryCodes = json['country_codes'].cast<String>();
    if (json['credentials'] != null) {
      credentials = new List<PlaidCredentials>();
      json['credentials'].forEach((v) {
        credentials.add(new PlaidCredentials.fromJson(v));
      });
    }
    hasMfa = json['has_mfa'];
    inputSpec = json['input_spec'];
    institutionId = json['institution_id'];
    logo = json['logo'];
    mfa = json['mfa'].cast<String>();
    mfaCodeType = json['mfa_code_type'];
    name = json['name'];
    oauth = json['oauth'];
    primaryColor = json['primary_color'];
    products = json['products'].cast<String>();
    routingNumbers = json['routing_numbers'].cast<String>();
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_codes'] = this.countryCodes;
    if (this.credentials != null) {
      data['credentials'] = this.credentials.map((v) => v.toJson()).toList();
    }
    data['has_mfa'] = this.hasMfa;
    data['input_spec'] = this.inputSpec;
    data['institution_id'] = this.institutionId;
    data['logo'] = this.logo;
    data['mfa'] = this.mfa;
    data['mfa_code_type'] = this.mfaCodeType;
    data['name'] = this.name;
    data['oauth'] = this.oauth;
    data['primary_color'] = this.primaryColor;
    data['products'] = this.products;
    data['routing_numbers'] = this.routingNumbers;
    data['url'] = this.url;
    return data;
  }
}
