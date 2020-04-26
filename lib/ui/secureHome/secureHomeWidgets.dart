import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:main/components/plaidLinkWebView.dart';
import 'package:main/constants/plaidConstants.dart';
import 'package:main/constants/secureHomeConstants.dart';

class SecureHomeWidgets  {
  static BuildContext context;
 
  static const TextStyle _optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> widgetOptions(BuildContext context){ 
    return <Widget>[
    Text(
      'Index 0: Home',
      style: _optionStyle,
    ),
    Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Center(
        child: new ButtonBar(
            mainAxisSize: MainAxisSize
                .min, // this will take space as minimum as posible(to center)
            children: <Widget>[
              RaisedButton(
                onPressed: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => PlaidLinkWebView(
                      websiteName: PlaidConstants.PLAID_LINK_WIDGET_TITLE,
                      websiteUrl: PlaidConstants.PLAID_LINK_URL,
                    )))
                },
                child: new Text(SecureHomeConstants.ADD_ACCOUNT),
                disabledColor: Colors.amber,
              )
            ]),
      ),
    ),
    Text(
      'Index 2: School',
      style: _optionStyle,
    ),
  ];
  }
}
