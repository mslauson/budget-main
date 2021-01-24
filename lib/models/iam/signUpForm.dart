class SignUpForm {
  String firstName;
  String middleName;
  String lastName;
  String phone;
  String emailAddress;
  String dob;

  SignUpForm(
      {this.firstName = '',
      this.middleName = '',
      this.lastName = '',
      this.phone = '',
      this.emailAddress = ''});

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "phone": phone,
        "emailAddress": emailAddress,
        "dob": dob
      };
}
