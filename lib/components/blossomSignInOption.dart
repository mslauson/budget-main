import 'package:flutter/cupertino.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class BlossomSignInOption extends StatelessWidget {
  final button;
  final text;
  final onPressed;

  BlossomSignInOption(
      {Key key,
      @required this.button,
      @required this.text,
      @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(5.0),
        child: SignInButton(
          button,
          text: text,
          onPressed: onPressed,
        ));
  }
}
