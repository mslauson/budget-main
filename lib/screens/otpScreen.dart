import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main/components/iconSso.dart';
import 'package:main/constants/iamConstants.dart';
import 'package:main/service/authenticationService.dart';
import 'package:main/theme/blossomText.dart';
import 'package:main/theme/svgPiggy.dart';
import 'package:main/ui/authenticate/authenticate.dart';

class OtpScreen extends StatelessWidget {
  final TextEditingController _controller = new TextEditingController();
  final AuthenticationService _authenticationService =
      new AuthenticationService(false, null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPiggy(),
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
                style: BlossomText.secondaryBody),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildButtons(context),
            )
          ],
        ),
      ),
    );
  }

  _validator(String val) {
    if (val.length == 0) {
      return "Value cannot be empty";
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
      IconSso(
          iconData: FontAwesomeIcons.arrowLeft,
          onPressed: () => {
                _authenticationService.acceptDialog(
                    context, _controller.text.trim()),
                _controller.dispose()
              })
    ];
  }
}
