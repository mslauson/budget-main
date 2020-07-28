import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:main/components/BlossomSignInOption.dart';
import 'package:main/components/googleAuthService.dart';
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
    final GoogleAuthService googleAuthService = new GoogleAuthService();
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
            BlossomSignInOption(
              text: "Continue With Google",
              button: Buttons.Google,
              onPressed: () => {googleAuthService.attemptAuth(context)},
            ),
            BlossomSignInOption(
              text: "Continue With Twitter",
              button: Buttons.Twitter,
              onPressed: () => {},
            ),
            BlossomSignInOption(
              text: "Continue With Facebook",
              button: Buttons.Facebook,
              onPressed: () => {},
            ),
          ],
        ),
      ),
    );
  }
}

const String _svg_l1em0x =
    '<svg viewBox="113.0 646.0 8.4 16.0" ><path transform="translate(33.0, 646.0)" d="M 85.42222595214844 16 L 85.42222595214844 8.711111068725586 L 87.91111755371094 8.711111068725586 L 88.26667785644531 5.8666672706604 L 85.42222595214844 5.8666672706604 L 85.42222595214844 4.088889122009277 C 85.42222595214844 3.288889169692993 85.68890380859375 2.666667222976685 86.84445190429688 2.666667222976685 L 88.35556030273438 2.666667222976685 L 88.35556030273438 0.08888889104127884 C 88 0.08888889104127884 87.11111450195313 0 86.13333129882813 0 C 84 0 82.4888916015625 1.333333373069763 82.4888916015625 3.733333110809326 L 82.4888916015625 5.866666793823242 L 80 5.866666793823242 L 80 8.711111068725586 L 82.4888916015625 8.711111068725586 L 82.4888916015625 16 L 85.42222595214844 16 Z" fill="#f6948c" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
