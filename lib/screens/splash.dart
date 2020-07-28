import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main/components/blossomSignInOption.dart';
import 'package:main/components/googleAuthService.dart';
import 'package:main/components/iconSso.dart';
import 'package:main/theme/blossomText.dart';
import 'package:main/theme/svgPiggy.dart';
import 'package:main/ui/authenticate/authenticate.dart';

class Splash extends StatelessWidget {
  Splash({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPiggy(),
            const SizedBox(height: 50),
            Text("Sign up with phone", style: BlossomText.title),
            const SizedBox(height: 25),
            BlossomSignInOption(
              text: "Continue With Phone",
              button: Buttons.Google,
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Authenticate()),
                )
              },
            ),
            const SizedBox(height: 75),
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
      IconSso(
          iconData: FontAwesomeIcons.google,
          onPressed: () => GoogleAuthService().attemptAuth(context)),
      IconSso(iconData: FontAwesomeIcons.twitter),
      IconSso(iconData: FontAwesomeIcons.facebookF)
    ];
  }
}
