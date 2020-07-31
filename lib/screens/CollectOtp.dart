import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main/components/iconSso.dart';
import 'package:main/constants/iamConstants.dart';
import 'package:main/service/auth/authenticationService.dart';
import 'package:main/theme/blossomText.dart';
import 'package:main/ui/authenticate/authenticate.dart';

class CollectOtp extends StatelessWidget {
  final TextEditingController _controller = new TextEditingController();
  final AuthenticationService _authenticationService =
      new AuthenticationService(false, null);
  final Function(String code) onSubmit;

  CollectOtp({Key key, @required this.onSubmit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 50),
              Text(IAMConstants.OTP_SCREEN_HEADER, style: BlossomText.title),
              const SizedBox(height: 25),
              new TextFormField(
                  decoration: new InputDecoration(
                    labelText: IAMConstants.OTP_TXT_DECORATION,
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  controller: _controller,
                  validator: (val) => _validator(val),
                  keyboardType: TextInputType.number,
                  style: BlossomText.body),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildButtons(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  _validator(String val) {
    if (val.length == 0) {
      return IAMConstants.INVALID_OTP;
    } else {
      return null;
    }
  }

  _buildButtons(BuildContext context) {
    return <Widget>[
      IconSso(
          iconData: FontAwesomeIcons.arrowLeft,
          onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Authenticate()),
              )),
      Padding(
        padding: EdgeInsets.fromLTRB(45, 0, 45, 0),
      ),
      IconSso(
          iconData: FontAwesomeIcons.arrowRight,
          onPressed: () =>
          {
            onSubmit(_controller.text.trim())})
    ];
  }
}
