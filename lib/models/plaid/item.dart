class Item {
  List<String> availableProducts;
  List<String> billedProducts;
  var consentExpirationTime;
  var error;
  String institutionId;
  String itemId;
  String webhook;

  Item(
      {this.availableProducts,
      this.billedProducts,
      this.consentExpirationTime,
      this.error,
      this.institutionId,
      this.itemId,
      this.webhook});

  Item.fromJson(Map<String, dynamic> json) {
    availableProducts = json['available_products'].cast<String>();
    billedProducts = json['billed_products'].cast<String>();
    consentExpirationTime = json['consent_expiration_time'];
    error = json['error'];
    institutionId = json['institution_id'];
    itemId = json['item_id'];
    webhook = json['webhook'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['available_products'] = this.availableProducts;
    data['billed_products'] = this.billedProducts;
    data['consent_expiration_time'] = this.consentExpirationTime;
    data['error'] = this.error;
    data['institution_id'] = this.institutionId;
    data['item_id'] = this.itemId;
    data['webhook'] = this.webhook;
    return data;
  }
}
