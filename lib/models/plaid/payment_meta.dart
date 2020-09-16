class PaymentMeta {
  var byOrderOf;
  var payee;
  var payer;
  var paymentMethod;
  var paymentProcessor;
  var ppdId;
  var reason;
  var referenceNumber;

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
    byOrderOf = json['by_order_of'];
    payee = json['payee'];
    payer = json['payer'];
    paymentMethod = json['payment_method'];
    paymentProcessor = json['payment_processor'];
    ppdId = json['ppd_id'];
    reason = json['reason'];
    referenceNumber = json['reference_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['by_order_of'] = this.byOrderOf;
    data['payee'] = this.payee;
    data['payer'] = this.payer;
    data['payment_method'] = this.paymentMethod;
    data['payment_processor'] = this.paymentProcessor;
    data['ppd_id'] = this.ppdId;
    data['reason'] = this.reason;
    data['reference_number'] = this.referenceNumber;
    return data;
  }
}
