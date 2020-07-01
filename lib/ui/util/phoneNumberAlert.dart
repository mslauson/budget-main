import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhoneNumberAlert {
  static Future<String> getPhoneNumber(BuildContext context) async {
    String _phoneNumber;
    await showDialog(
        context: context,
        child: AlertDialog(
          content: Material(
            type: MaterialType.card,
            child: new Container(
              margin: EdgeInsets.only(left: 26.0, right: 26.0),
              decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                color: const Color(0xFFFFFF),
                borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
              ),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // dialog top
                  Text('Please Provide Phone Number'),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone #',
                    ),
                    onChanged: (val) => _phoneNumber = val.trim(),
                  ),
                   CloseButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          ),
        ));
    return _phoneNumber;
  }


}
