import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main/components/iconActionButton.dart';
import 'package:main/components/outlineActionButton.dart';
import 'package:main/service/auth/googleAuthService.dart';
import 'package:main/theme/blossom_text.dart';
import 'package:main/theme/svg_piggy.dart';
import 'package:main/ui/authenticate/authenticate.dart';

class Splash extends StatelessWidget {
  Splash({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Blossom", style: BlossomText.headline),
            const SizedBox(height: 50),
            SvgPiggy(),
            const SizedBox(height: 50),
            OutlineActionButton(
              text: "Sign in with Phone",
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Authenticate()),
                )
              },
            ),
            const SizedBox(height: 10),
            Form(
              child: InternationalPhoneNumberInput(
                initialValue:
                    PhoneNumber(phoneNumber: '7155739797', isoCode: 'US'),
                hintText: 'Mobile Number',
                ignoreBlank: false,
                autoValidate: false,
                countries: GlobalConstants.countryCodes,
                selectorTextStyle: TextStyle(color: Colors.black),
                inputBorder: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Text("Or continue with", style: BlossomText.largeBody),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildSsoOptions(context),
            )
          ],
        ),
      ),
    );
  }

  _buildSsoOptions(BuildContext context) {
    return <Widget>[
      IconActionButton(
        iconData: FontAwesomeIcons.google,
        onPressed: () => GoogleAuthService().attemptAuth(context),
      ),
      IconActionButton(
        iconData: FontAwesomeIcons.twitter,
      ),
      IconActionButton(
        iconData: FontAwesomeIcons.facebookF,
      )
    ];
  }
}
