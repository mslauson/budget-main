import 'package:main/models/plaid/request/plaid_request_options.dart';

class PlaidTransactionsRequest {
  String clientId;
  String secret;
  String accessToken;
  String startDate;
  String endDate;
  Options options;

  PlaidTransactionsRequest(
      {this.clientId,
      this.secret,
      this.accessToken,
      this.startDate,
      this.endDate,
      this.options});

  PlaidTransactionsRequest.fromJson(Map<String, dynamic> json) {
    clientId = json['client_id'];
    secret = json['secret'];
    accessToken = json['access_token'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    options =
        json['options'] != null ? new Options.fromJson(json['options']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['client_id'] = this.clientId;
    data['secret'] = this.secret;
    data['access_token'] = this.accessToken;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    if (this.options != null) {
      data['options'] = this.options.toJson();
    }
    return data;
  }
}
