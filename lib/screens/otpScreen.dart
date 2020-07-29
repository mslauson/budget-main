import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main/components/iconSso.dart';
import 'package:main/theme/blossomText.dart';
import 'package:main/theme/svgPiggy.dart';
import 'package:main/ui/authenticate/authenticate.dart';

class OtpScreen extends StatelessWidget {

  final String prompt;
  final String txtLabel;
  final TextEditingController controller = new TextEditingController();

  OtpScreen(this.prompt, this.txtLabel);


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
            Text(prompt, style: BlossomText.title),
            const SizedBox(height: 25),
            new TextFormField(
                decoration: new InputDecoration(
                  labelText: txtLabel,
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                controller: controller,
                validator: (val) {
                  if (val.length == 0) {
                    return "Value cannot be empty";
                  }
                  else {
                    return null;
                  }
                },
                keyboardType: TextInputType.number,
                style: BlossomText.secondaryBody
            ),
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
          iconData: FontAwesomeIcons.arrowLeft,
          onPressed: () =>
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Authenticate()),
              )),
      IconSso(iconData: FontAwesomeIcons.arrowLeft,
          onPressed: () =>)
    ];
  }
}