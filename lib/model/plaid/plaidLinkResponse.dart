class PlaidLinkResponse {
  String accessToken;
  String email;
  String linkSessionId;
  Institution institution;

  PlaidLinkResponse(
      {this.accessToken, this.email, this.linkSessionId, this.institution});

  PlaidLinkResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    email = json['email'];
    linkSessionId = json['linkSessionId'];
    institution = json['institution'] != null
        ? new Institution.fromJson(json['institution'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['email'] = this.email;
    data['linkSessionId'] = this.linkSessionId;
    if (this.institution != null) {
      data['institution'] = this.institution.toJson();
    }
    return data;
  }
}

class Institution {
  String name;
  String institutionId;

  Institution({this.name, this.institutionId});

  Institution.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    institutionId = json['institutionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['institutionId'] = this.institutionId;
    return data;
  }
}