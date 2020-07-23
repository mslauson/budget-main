import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:main/models/global/activeUser.dart';
import 'package:main/models/iam/authenticationModel.dart';
import 'package:main/service/authenticationService.dart';
import 'package:scoped_model/scoped_model.dart';

class NewUserFullName extends StatelessWidget {
  String _lastLogin = '';

  @override
  Widget build(BuildContext context) {
    AuthenticationModel authenticationModel = new AuthenticationModel();
    AuthenticationService _authService = new AuthenticationService();
    bool validForm;
    return Scaffold(
      body: ScopedModelDescendant<ActiveUser>(
          builder: (BuildContext context, Widget child, ActiveUser model) {
        return new Container(
            padding: const EdgeInsets.all(30.0),
            color: Colors.white,
            child: new Container(
              child: new Center(
                  child: new Column(children: [
                new Padding(padding: EdgeInsets.only(top: 140.0)),
                new Text(
                  'Please Provide Blossom With Name',
                  style: new TextStyle(color: Colors.black, fontSize: 25.0),
                ),
                new Padding(padding: EdgeInsets.only(top: 50.0)),
                new TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Enter Full Name",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                  validator: (val) {
                    if (val.length == 0) {
                      return "Email cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
              ])),
            ));
      }),
    );
  }
}
