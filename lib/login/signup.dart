import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:main/client/customerClient.dart';
import 'package:main/constants/signUpConstants.dart';
import 'package:main/model/otikaForm.dart';
import 'package:main/model/signUpForm.dart';

class SignUp extends StatefulWidget {
  final SignUpConstants signUpConstants;
  final CustomerClient customerClient;
  const SignUp({
    Key key,
    this.signUpConstants,
    this.customerClient,
  }) : super(key: key);

  @override
  SignUpState createState() {
    return SignUpState();
  }
}

class SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    bool validForm;
    SignUpForm signUpForm = new SignUpForm();
    OtikaForm otikaForm = new OtikaForm();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 8, top: 32, right: 8),
          child: Material(
            elevation: 1,
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(8),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  AppBar(
                    leading: Icon(Icons.verified_user),
                    elevation: 0,
                    title: Text(SignUpConstants.FORM_TITLE),
                    backgroundColor: Theme.of(context).accentColor,
                    centerTitle: true,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: TextFormField(
                      initialValue: '',
                      onSaved: (val) => signUpForm.userName = val,
                      validator: (val) => validateUserName(val),
                      decoration: InputDecoration(
                        labelText: SignUpConstants.USERNAME,
                        hintText: SignUpConstants.USERNAME_HINT,
                        icon: Icon(Icons.person),
                        isDense: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                    child: TextFormField(
                      initialValue: '',
                      onSaved: (val) => signUpForm.emailAddress = val,
                      validator: (val) => validateEmail(val),
                      decoration: InputDecoration(
                        labelText: SignUpConstants.EMAIL_ADDRESS,
                        hintText: SignUpConstants.EMAIL_ADDRESS_HINT,
                        icon: Icon(Icons.email),
                        isDense: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                    child: TextFormField(
                      initialValue: '',
                      onSaved: (val) => otikaForm.password = val,
                      validator: (val) => val.length > 0
                          ? null
                          : SignUpConstants.INVALID_PASSWORD,
                      decoration: InputDecoration(
                        labelText: SignUpConstants.PASSWORD,
                        hintText: SignUpConstants.PASSWORD_HINT,
                        icon: Icon(Icons.payment),
                        isDense: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                    child: TextFormField(
                      initialValue: '',
                      onSaved: (val) => signUpForm.firstName = val,
                      validator: (val) => val.length > 0
                          ? null
                          : SignUpConstants.INVALID_FIRST_NAME,
                      decoration: InputDecoration(
                        labelText: SignUpConstants.FIRST_NAME,
                        hintText: SignUpConstants.FIRST_NAME_HINT,
                        icon: Icon(Icons.people),
                        isDense: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                    child: TextFormField(
                      initialValue: '',
                      onSaved: (val) => signUpForm.middleName = val,
                      validator: (val) => validateMiddleIntial(val),
                      decoration: InputDecoration(
                        labelText: SignUpConstants.MIDDLE_INITIAL,
                        hintText: SignUpConstants.MIDDLE_INITIAL_HINT,
                        icon: Icon(Icons.people),
                        isDense: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                    child: TextFormField(
                      initialValue: '',
                      onSaved: (val) => signUpForm.lastName = val,
                      validator: (val) => val.length > 0
                          ? null
                          : SignUpConstants.INVALID_LAST_NAME,
                      decoration: InputDecoration(
                        labelText: SignUpConstants.LAST_NAME,
                        hintText: SignUpConstants.LAST_NAME_HINT,
                        icon: Icon(Icons.people),
                        isDense: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                    child: TextFormField(
                      initialValue: '',
                      onSaved: (val) => signUpForm.phone = val,
                      validator: (val) => val.length != 9
                          ? null
                          : SignUpConstants.INVALID_PHONE,
                      decoration: InputDecoration(
                        labelText: SignUpConstants.PHONE,
                        hintText: SignUpConstants.PHONE_HINT,
                        icon: Icon(Icons.people),
                        isDense: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                    child: new Center(
                      child: new ButtonBar(
                          mainAxisSize: MainAxisSize
                              .min, // this will take space as minimum as posible(to center)
                          children: <Widget>[
                            RaisedButton(
                              color: Theme.of(context).accentColor,
                              onPressed: () => {
                                validForm = validateCurrentForm(formKey),
                                addCustomer(validForm, signUpForm, otikaForm)
                              },
                              child: new Text(SignUpConstants.SUBMIT),
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
      ),
    );
  }
}

String validateUserName(String val){
  if(val.length == 0){
    return SignUpConstants.INVALID_USERNAME_LENGTH;
  }
  else if( val.length < 5 || val.length> 30){
    return SignUpConstants.INVALID_USERNAME_LENGTH;
  }
  return null;
}

// validates that the email address is in the correct format and doesn't have a length of 0
String validateEmail(String value) {
  if (!value.contains('@')) {
    return SignUpConstants.INVALID_EMAIL;
  } else if (value.length == 0) {
    return SignUpConstants.INVALID_EMAIL_REQUIRED;
  }

  return null;
}

String validateMiddleIntial(String middleInitial) {
  if (middleInitial.length > 0) {
    if (middleInitial.length > 1) {
      return SignUpConstants.INVALID_MIDDLE_INITIAL;
    }
  }
  return null;
}

SignUpForm addCustomer(
    bool validForm, SignUpForm signUpForm, OtikaForm otikaForm) {
  if (validForm) {
    CustomerClient client = new CustomerClient();
    SignUpForm response = client.addCustomer(jsonEncode(signUpForm.toJson()));
    log(response.toString());
    otikaForm.email = signUpForm.emailAddress;
    return response;
  }
  return null;
}

bool validateCurrentForm(GlobalKey<FormState> formKey) {
  final currentState = formKey.currentState;
  if (currentState.validate()) {
    currentState.save();
    return true;
  }
  return false;
}
