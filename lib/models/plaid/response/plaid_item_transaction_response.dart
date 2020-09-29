class PlaidItemTransactionResponse {
  String lastSuccessfulUpdate;
  String lastFailedUpdate;

  PlaidItemTransactionResponse(
      {this.lastSuccessfulUpdate, this.lastFailedUpdate});

  PlaidItemTransactionResponse.fromJson(Map<String, dynamic> json) {
    lastSuccessfulUpdate = json['last_successful_update'];
    lastFailedUpdate = json['last_failed_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['last_successful_update'] = this.lastSuccessfulUpdate;
    data['last_failed_update'] = this.lastFailedUpdate;
    return data;
  }
}
