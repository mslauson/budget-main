class PutTransactionsRequest {
  String accessToken;
  String startDate;
  String endDate;
  String email;

  PutTransactionsRequest(
      {this.accessToken, this.startDate, this.endDate, this.email});

  PutTransactionsRequest.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['email'] = this.email;
    return data;
  }
}
