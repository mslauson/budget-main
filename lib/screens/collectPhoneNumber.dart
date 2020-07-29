import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:main/components/iconSso.dart';
import 'package:main/constants/iamConstants.dart';
import 'package:main/screens/splash.dart';
import 'package:main/theme/blossomText.dart';

class CollectPhoneNumber extends StatelessWidget {
  final TextEditingController _controller = new TextEditingController();
  final GoogleSignInAccount signInAccount;
  final Function(String phone) onSubmitted;

  CollectPhoneNumber({Key key, this.signInAccount, this.onSubmitted})
      : super(key: key);

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
              Text(IAMConstants.PHONE_HINT, style: BlossomText.title),
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
      return IAMConstants.INVALID_PHONE;
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
                MaterialPageRoute(builder: (context) => Splash()),
              )),
      Padding(
        padding: EdgeInsets.fromLTRB(45, 0, 45, 0),
      ),
      IconSso(
          iconData: FontAwesomeIcons.arrowRight,
          onPressed: () => {
            onSubmitted(_controller.text)})
    ];
  }

}
