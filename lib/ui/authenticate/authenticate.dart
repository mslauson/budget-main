import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:main/constants/iamConstants.dart';
import 'package:main/models/global/activeUser.dart';
import 'package:main/models/iam/authenticationModel.dart';
import 'package:main/ui/secureHome/secureHome.dart';
import 'package:main/util/formUtils.dart';
import 'package:scoped_model/scoped_model.dart';

class Authenticate extends StatelessWidget {
  String _lastLogin = '';

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
AuthenticationModel authenticationModel = new AuthenticationModel();
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
                            authenticationForm.username = val.trim(),
                        decoration: InputDecoration(
                          labelText: IAMConstants.USERNAME,
                          icon: Icon(Icons.person),
                          isDense: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: TextFormField(
                        initialValue: '',
                        onSaved: (val) =>
                            authenticationForm.password = val.trim(),
                        decoration: InputDecoration(
                          labelText: IAMConstants.PASSWORD,
                          icon: Icon(Icons.vpn_key),
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
                                  validForm =
                                      FormUtils.validateCurrentForm(formKey),
                                  _authenticateUser(
                                          validForm, authenticationForm)
                                      .whenComplete(() {
                                    model.email = authenticationForm.username;
                                    if (_lastLogin != null) {
                                      model.lastLogin = _lastLogin;
                                    }
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              new SecureHome()),
                                    );
                                  }),
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

  Future<void> _authenticateUser(
      bool validForm, AuthenticationModel authenticationForm) async {
    await _authenticateFirebase(validForm, authenticationForm);
  }

  _authenticateFirebase(
      bool validForm, Authentication Model authenticationModel) async {
    final _auth = FirebaseAuth.instance;
    AuthResult response = await _auth.signInWithEmailAndPassword(
        email: authenticationForm.username,
        password: authenticationForm.password);
    _lastLogin = response.user.metadata.lastSignInTime.toIso8601String();
    print(response);
  }
}
