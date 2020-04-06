class SignUpForm {
  String userName;
  String firstName;
  String middleName;
  String lastName;
  String phone;
  String emailAddress;
  SignUpForm(
      {this.userName = '',
      this.firstName = '',
      this.middleName = '',
      this.lastName = '',
      this.phone = '',
      this.emailAddress = ''});

Map<String, dynamic> toJson() => {
      "userName" : userName,
      "firstName": firstName, 
      "middleName" : middleName,
      "lastName" : lastName,
      "phone" : phone,
      "emailAddress" : emailAddress     
};
}
