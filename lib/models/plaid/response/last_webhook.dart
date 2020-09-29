class LastWebhook {
  String sentAt;
  String codeSent;

  LastWebhook({this.sentAt, this.codeSent});

  LastWebhook.fromJson(Map<String, dynamic> json) {
    sentAt = json['sent_at'];
    codeSent = json['code_sent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sent_at'] = this.sentAt;
    data['code_sent'] = this.codeSent;
    return data;
  }
}
