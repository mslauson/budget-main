import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:main/components/googleAuthService.dart';
import 'package:main/models/global/activeUser.dart';
import 'package:main/ui/authenticate/authenticate.dart';
import 'package:main/ui/signUp/signup.dart';
import 'package:scoped_model/scoped_model.dart';

class Splash extends StatelessWidget {
  Splash({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final GoogleAuthService continueWithGoogle = new GoogleAuthService();
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return ScopedModelDescendant<ActiveUser>(
        builder: (BuildContext context, Widget child, ActiveUser model)
    {
      return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("testing"),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 250),
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: SignInButton(
                    Buttons.Email,
                    text: "Sign up with Email",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUp()),
                      );
                    },
                  )),
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: SignInButton(
                    Buttons.Google,
                    text: "Sign up with Google",
                    onPressed: () {
                      continueWithGoogle.attemptAuth(context);
                    },
                  )),
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: SignInButton(
                    Buttons.Twitter,
                    text: "Sign up with Twitter",
                    onPressed: () {},
                  )),
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
    );
  }
}
