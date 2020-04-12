import 'package:main/model/valueModel.dart';

class OktaCredentials {
  ValueModel password;
  OktaCredentials(this.password);
  Map<String, dynamic> toJson() => {"password": password};
}
