class OktaProfile {
  String firstName;
  String lastName;
  String email;
  String login;
  String mobilePhone;
  OktaProfile(
      {this.firstName,
      this.lastName,
      this.email,
      this.login,
      this.mobilePhone});

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "login": login,
        "mobilePhone": mobilePhone,
      };
}
