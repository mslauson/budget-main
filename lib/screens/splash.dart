import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main/components/iconActionButton.dart';
import 'package:main/constants/global_constants.dart';
import 'package:main/service/auth/googleAuthService.dart';
import 'package:main/theme/blossom_text.dart';
import 'package:main/theme/svg_piggy.dart';
import 'package:main/widgets/phone-input-form.dart';

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
            Spacer(flex: 3),
            Text(GlobalConstants.appName, style: BlossomText.headline),
            Spacer(flex: 2),
            SvgPiggy(),
            Spacer(flex: 2),
            PhoneInputForm(),
            Spacer(flex: 1),
            Text("Or continue with", style: BlossomText.largeBody),
            Spacer(flex: 1),
            _buildSsoOptions(context),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  Widget _buildSsoOptions(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconActionButton(
            iconData: FontAwesomeIcons.google,
            onPressed: () => GoogleAuthService().attemptAuth(context),
          ),
          IconActionButton(
            iconData: FontAwesomeIcons.twitter,
          ),
          IconActionButton(
            iconData: FontAwesomeIcons.facebookF,
          ),
        ],
      );
}
