class TokenExchangeResponse {
  String requestId;
  String accessToken;
  String itemId;

  TokenExchangeResponse({this.requestId, this.accessToken, this.itemId});

  TokenExchangeResponse.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
    accessToken = json['accessToken'];
    itemId = json['itemId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requestId'] = this.requestId;
    data['accessToken'] = this.accessToken;
    data['itemId'] = this.itemId;
    return data;
  }
}
