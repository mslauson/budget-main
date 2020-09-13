import 'package:main/models/plaid/plaid_institution.dart';

class PlaidInstitutionMetaResponse {
  PlaidInstitution institution;
  String requestId;

  PlaidInstitutionMetaResponse({this.institution, this.requestId});

  PlaidInstitutionMetaResponse.fromJson(Map<String, dynamic> json) {
    institution = json['institution'] != null
        ? new PlaidInstitution.fromJson(json['institution'])
        : null;
    requestId = json['request_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.institution != null) {
      data['institution'] = this.institution.toJson();
    }
    data['request_id'] = this.requestId;
    return data;
  }
}
