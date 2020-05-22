import 'package:scoped_model/scoped_model.dart';

class ActiveUser extends Model {
  String email;

  ActiveUser({this.email});

  ActiveUser.fromJson(Map<String, dynamic> json) {
    email = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.email;
    return data;
  }
}