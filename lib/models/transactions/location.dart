class Location {
  String address;
  String city;
  int lat;
  int lon;
  String region;
  String storeNumber;
  String postalCode;
  String country;

  Location(
      {this.address,
      this.city,
      this.lat,
      this.lon,
      this.region,
      this.storeNumber,
      this.postalCode,
      this.country});

  Location.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    city = json['city'];
    lat = json['lat'];
    lon = json['lon'];
    region = json['region'];
    storeNumber = json['storeNumber'];
    postalCode = json['postalCode'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['city'] = this.city;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['region'] = this.region;
    data['storeNumber'] = this.storeNumber;
    data['postalCode'] = this.postalCode;
    data['country'] = this.country;
    return data;
  }
}
