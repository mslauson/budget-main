import 'package:main/models/valueModel.dart';

class OktaCredentials {
  ValueModel password;
  OktaCredentials(this.password);
  Map<String, dynamic> toJson() => {"password": password};
}
