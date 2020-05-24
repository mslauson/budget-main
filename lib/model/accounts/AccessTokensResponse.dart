class AccessTokensResponse {
  List<AccessTokens> accessTokens;

  AccessTokensResponse({this.accessTokens});

  AccessTokensResponse.fromJson(Map<String, dynamic> json) {
    if (json['accessTokens'] != null) {
      accessTokens = new List<AccessTokens>();
      json['accessTokens'].forEach((v) {
        accessTokens.add(new AccessTokens.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.accessTokens != null) {
      data['accessTokens'] = this.accessTokens.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AccessTokens {
  String accessToken;

  AccessTokens({this.accessToken});

  AccessTokens.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    return data;
  }
}
