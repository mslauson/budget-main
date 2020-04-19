import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:main/constants/globalConstants.dart';
import 'package:main/constants/secureHomeConstants.dart';

class SecureHomeWidgets{
  // static const BorderRadius borderRadius = new BorderRadius.circular(8);
  static const TextStyle _optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> widgetOptions = <Widget>[
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