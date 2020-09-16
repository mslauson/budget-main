class PaymentMeta {
  String byOrderOf;
  String payee;
  String payer;
  String paymentMethod;
  String paymentProcessor;
  String ppdId;
  String reason;
  String referenceNumber;

  PaymentMeta(
      {this.byOrderOf,
      this.payee,
      this.payer,
      this.paymentMethod,
      this.paymentProcessor,
      this.ppdId,
      this.reason,
      this.referenceNumber});

  PaymentMeta.fromJson(Map<String, dynamic> json) {
    byOrderOf = json['byOrderOf'];
    payee = json['payee'];
    payer = json['payer'];
    paymentMethod = json['paymentMethod'];
    paymentProcessor = json['paymentProcessor'];
    ppdId = json['ppdId'];
    reason = json['reason'];
    referenceNumber = json['referenceNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['byOrderOf'] = this.byOrderOf;
    data['payee'] = this.payee;
    data['payer'] = this.payer;
    data['paymentMethod'] = this.paymentMethod;
    data['paymentProcessor'] = this.paymentProcessor;
    data['ppdId'] = this.ppdId;
    data['reason'] = this.reason;
    data['referenceNumber'] = this.referenceNumber;
    return data;
  }
}
