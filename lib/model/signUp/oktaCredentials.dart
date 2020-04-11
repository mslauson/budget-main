class OktaCredentials {
  String password;
  OktaCredentials(this.password);
  Map<String, dynamic> toJson() => {"password": password};
}
