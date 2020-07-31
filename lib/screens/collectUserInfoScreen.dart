import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main/components/iconActionButton.dart';
import 'package:main/constants/iamConstants.dart';
import 'package:main/theme/blossomText.dart';
import 'package:main/ui/authenticate/authenticate.dart';

class CollectUserInfoScreen extends StatelessWidget {
  final String phone;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  CollectUserInfoScreen({this.phone});

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
              Text(IAMConstants.OTP_SCREEN_HEADER, style: BlossomText.title),
              const SizedBox(height: 25),
              TextFormField(
                  decoration: new InputDecoration(
                    labelText: IAMConstants.OTP_TXT_DECORATION,
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  controller: _fullNameController,
                  validator: (val) => _validateName(val),
                  keyboardType: TextInputType.text,
                  style: BlossomText.body),
              const SizedBox(height: 25),
              TextFormField(
                  decoration: new InputDecoration(
                    labelText: IAMConstants.OTP_TXT_DECORATION,
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  controller: _emailController,
                  validator: (val) => _validateEmail(val),
                  keyboardType: TextInputType.emailAddress,
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

  List<String> splitName(String fullName) {
    return fullName.split(" ");
  }

  _buildButtons(BuildContext context) {
    return <Widget>[
      IconActionButton(
          iconData: FontAwesomeIcons.arrowLeft,
          onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Authenticate()),
              )),
      Padding(
        padding: EdgeInsets.fromLTRB(45, 0, 45, 0),
      ),
      IconActionButton(
          iconData: FontAwesomeIcons.arrowRight,
          onPressed: () => {
//            onSubmit(_controller.text.trim())
              })
    ];
  }

  String _validateName(String val) {
    int temp = val.trim().indexOf(" ");
    if (val.length == 0) {
      return IAMConstants.INVALID_FULL_NAME;
    }
//                            else if (val.trim().indexOf(" ") != 1) {
//                              return "Please provide full name";
//                            }
    else {
      return null;
    }
  }

  String _validateEmail(String val) {
    if (val.length == 0) {
      return IAMConstants.INVALID_EMAIL_REQUIRED;
    } else if (!EmailValidator.validate(val)) {
      return IAMConstants.INVALID_EMAIL;
    } else {
      return null;
    }
  }
}
