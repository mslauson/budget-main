import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:main/constants/iamConstants.dart';
import 'package:main/model/iam/authenticateForm.dart';

class Authenticate extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    AuthenticationForm authenticationForm = new AuthenticationForm();
     return Scaffold(
      body: SingleChildScrollView(
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
                      onSaved: (val) => authenticationForm.username = val.trim(),
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
                      onSaved: (val) => authenticationForm.password = val.trim(),
                      decoration: InputDecoration(
                        labelText: IAMConstants.PASSWORD,
                        icon: Icon(Icons.vpn_key),
                        isDense: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ), 
     );
  }
}
