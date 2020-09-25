class Balances {
  double available;
  double current;
  String isoCurrencyCode;
  var limit;
  var unofficialCurrencyCode;

  Balances(
      {this.available,
      this.current,
      this.isoCurrencyCode,
      this.limit,
      this.unofficialCurrencyCode});

  Balances.fromJson(Map<String, dynamic> json) {
    available = json['available'];
    current = json['current'];
    isoCurrencyCode = json['iso_currency_code'];
    limit = json['limit'];
    unofficialCurrencyCode = json['unofficial_currency_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['available'] = this.available;
    data['current'] = this.current;
    data['iso_currency_code'] = this.isoCurrencyCode;
    data['limit'] = this.limit;
    data['unofficial_currency_code'] = this.unofficialCurrencyCode;
    return data;
  }
}
