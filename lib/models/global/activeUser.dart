import 'package:scoped_model/scoped_model.dart';

class ActiveUser extends Model {
  String phone;
  String lastLogin;

  ActiveUser({this.phone, this.lastLogin});

  ActiveUser.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    lastLogin = json['lastLogin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['lastLogin'] = this.lastLogin;
    return data;
  }
}