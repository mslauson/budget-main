import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main/components/googleAuthService.dart';
import 'package:main/components/iconSso.dart';
import 'package:main/components/outlineActionButton.dart';
import 'package:main/theme/blossomText.dart';
import 'package:main/theme/svgPiggy.dart';
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
      IconSso(
        iconData: FontAwesomeIcons.google,
        onPressed: () => GoogleAuthService().attemptAuth(context),
      ),
      IconSso(
        iconData: FontAwesomeIcons.twitter,
      ),
      IconSso(
        iconData: FontAwesomeIcons.facebookF,
      )
    ];
  }
}
