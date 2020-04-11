import 'package:main/model/signUp/oktaCredentials.dart';
import 'package:main/model/signUp/oktaProfile.dart';

class OktaForm {
  OktaProfile profile;
  OktaCredentials credentials;
  OktaForm({this.profile, this.credentials});

  Map<String, dynamic> toJson() =>
      {"profile": profile, "credentials": credentials};
}
