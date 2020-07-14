class AuthenticationModel {
  String username;
  String password;

  AuthenticationModel({String username, String password}) {
    this.username = username;
    this.password = password;
  }

  AuthenticationModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }
}