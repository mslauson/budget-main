import 'package:scoped_model/scoped_model.dart';

class ActiveUser extends Model {
  String email;
  String lastLogin;

  ActiveUser({this.email, this.lastLogin});

  ActiveUser.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    lastLogin = json['lastLogin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['lastLogin'] = this.lastLogin;
    return data;
  }
}