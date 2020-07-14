import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:main/constants/iamConstants.dart';
import 'package:main/models/global/activeUser.dart';
import 'package:main/models/iam/authenticationModel.dart';
import 'package:main/service/authenticationService.dart';
import 'package:main/ui/secureHome/secureHome.dart';
import 'package:main/util/formUtils.dart';
import 'package:scoped_model/scoped_model.dart';

class Authenticate extends StatelessWidget {
  String _lastLogin = '';

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    AuthenticationModel authenticationModel = new AuthenticationModel();
    AuthenticationService _authService = new AuthenticationService();
    bool validForm;
    return Scaffold(
      body: ScopedModelDescendant<ActiveUser>(
          builder: (BuildContext context, Widget child, ActiveUser model) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 8, top: 32, right: 8, bottom: 32),
            child: Material(
              elevation: 2,
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(8),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    AppBar(
                      elevation: 0,
                      title: Text(IAMConstants.LOGIN_TITLE),
                      backgroundColor: Theme.of(context).accentColor,
                      centerTitle: true,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: TextFormField(
                        initialValue: '',
                        onSaved: (val) =>
                            authenticationModel.phoneNumber = val.trim(),
                        decoration: InputDecoration(
                          labelText: IAMConstants.PHONE,
                          icon: Icon(Icons.person),
                          isDense: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: new Center(
                        child: new ButtonBar(mainAxisSize: MainAxisSize.min,
                            // this will take space as minimum as posible(to center)
                            children: <Widget>[
                              RaisedButton(
                                color: Theme.of(context).accentColor,
                                onPressed: () => {
                                  if (FormUtils.validateCurrentForm(formKey))
                                    {
                                      _authService.authenticateUser(
                                          authenticationModel, context)
                                    }
                                },
                                child: new Text(IAMConstants.SUBMIT),
                                disabledColor: Colors.amber,
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
