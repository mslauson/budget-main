class Location {
  String address;
  String city;
  String region;
  String postalCode;
  String country;
  double lat;
  double lon;
  String storeNumber;

  Location(
      {this.address,
      this.city,
      this.region,
      this.postalCode,
      this.country,
      this.lat,
      this.lon,
      this.storeNumber});

  Location.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    city = json['city'];
    region = json['region'];
    postalCode = json['postal_code'];
    country = json['country'];
    lat = json['lat'];
    lon = json['lon'];
    storeNumber = json['store_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['city'] = this.city;
    data['region'] = this.region;
    data['postal_code'] = this.postalCode;
    data['country'] = this.country;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['store_number'] = this.storeNumber;
    return data;
  }
}
