class PlaidItem {
  List<String> availableProducts;
  List<String> billedProducts;
  Null error;
  String institutionId;
  String itemId;
  String webhook;
  int consentExpirationTime;

  PlaidItem(
      {this.availableProducts,
      this.billedProducts,
      this.error,
      this.institutionId,
      this.itemId,
      this.webhook,
      this.consentExpirationTime});

  PlaidItem.fromJson(Map<String, dynamic> json) {
    availableProducts = json['available_products'].cast<String>();
    billedProducts = json['billed_products'].cast<String>();
    error = json['error'];
    institutionId = json['institution_id'];
    itemId = json['item_id'];
    webhook = json['webhook'];
    consentExpirationTime = json['consent_expiration_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['available_products'] = this.availableProducts;
    data['billed_products'] = this.billedProducts;
    data['error'] = this.error;
    data['institution_id'] = this.institutionId;
    data['item_id'] = this.itemId;
    data['webhook'] = this.webhook;
    data['consent_expiration_time'] = this.consentExpirationTime;
    return data;
  }
}
