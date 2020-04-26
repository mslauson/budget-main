import 'package:scoped_model/scoped_model.dart';

class ActiveUser extends Model {
  String user;

  ActiveUser({this.user});

  ActiveUser.fromJson(Map<String, dynamic> json) {
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    return data;
  }
}