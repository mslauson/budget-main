import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main/components/iconActionButton.dart';
import 'package:main/constants/iamConstants.dart';
import 'package:main/screens/splash.dart';
import 'package:main/theme/blossomText.dart';

class CollectPhoneNumber extends StatelessWidget {
  final TextEditingController _controller = new TextEditingController();
  final Function(String phone) onSubmitted;

  CollectPhoneNumber({Key key, @required this.onSubmitted}) : super(key: key);

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
                    labelText: IAMConstants.PHONE,
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
      IconActionButton(
          iconData: FontAwesomeIcons.arrowLeft,
          onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Splash()),
              )),
      Padding(
        padding: EdgeInsets.fromLTRB(45, 0, 45, 0),
      ),
      IconActionButton(
          iconData: FontAwesomeIcons.arrowRight,
          onPressed: () => {onSubmitted("+1" + _controller.text)})
    ];
  }

}
