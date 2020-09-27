class UpdateWebhookRequestModel {
  String clientId;
  String secret;
  String accessToken;
  String webhook;

  UpdateWebhookRequestModel(
      {this.clientId, this.secret, this.accessToken, this.webhook});

  UpdateWebhookRequestModel.fromJson(Map<String, dynamic> json) {
    clientId = json['client_id'];
    secret = json['secret'];
    accessToken = json['access_token'];
    webhook = json['webhook'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['client_id'] = this.clientId;
    data['secret'] = this.secret;
    data['access_token'] = this.accessToken;
    data['webhook'] = this.webhook;
    return data;
  }
}
