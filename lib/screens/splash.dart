import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:main/components/BlossomSignInOption.dart';
import 'package:main/components/googleAuthService.dart';
import 'package:main/theme/svgPiggy.dart';
import 'package:main/ui/authenticate/authenticate.dart';
import 'package:main/ui/signUp/signup.dart';

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
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPiggy(),
            const SizedBox(height: 175),
            BlossomSignInOption(
              text: "Sign up with Email",
              button: Buttons.Email,
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUp()),
                )
              },
            ),
            BlossomSignInOption(
              text: "Continue with Google",
              button: Buttons.Google,
              onPressed: () => {
              googleAuthService.attemptAuth(context)
              },
            ),
            BlossomSignInOption(
              text: "Continue with Twitter",
              button: Buttons.Twitter,
              onPressed: () => {},
            ),
            BlossomSignInOption(
              text: "Continue with Facebook",
              button: Buttons.Facebook,
              onPressed: () => {},
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: GestureDetector(
                  child: Text("Log In Using Email",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Authenticate()),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

const String _svg_l1em0x =
    '<svg viewBox="113.0 646.0 8.4 16.0" ><path transform="translate(33.0, 646.0)" d="M 85.42222595214844 16 L 85.42222595214844 8.711111068725586 L 87.91111755371094 8.711111068725586 L 88.26667785644531 5.8666672706604 L 85.42222595214844 5.8666672706604 L 85.42222595214844 4.088889122009277 C 85.42222595214844 3.288889169692993 85.68890380859375 2.666667222976685 86.84445190429688 2.666667222976685 L 88.35556030273438 2.666667222976685 L 88.35556030273438 0.08888889104127884 C 88 0.08888889104127884 87.11111450195313 0 86.13333129882813 0 C 84 0 82.4888916015625 1.333333373069763 82.4888916015625 3.733333110809326 L 82.4888916015625 5.866666793823242 L 80 5.866666793823242 L 80 8.711111068725586 L 82.4888916015625 8.711111068725586 L 82.4888916015625 16 L 85.42222595214844 16 Z" fill="#f6948c" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
