import 'dart:convert';
import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:main/client/customerClient.dart';
import 'package:main/client/oktaClient.dart';
import 'package:main/constants/iamConstants.dart';
import 'package:main/model/iam/oktaCredentials.dart';
import 'package:main/model/iam/oktaForm.dart';
import 'package:main/model/iam/oktaProfile.dart';
import 'package:main/model/iam/signUpForm.dart';
import 'package:main/ui/home/splash.dart';

import 'package:main/model/valueModel.dart';
import 'package:main/util/formUtils.dart';

class SignUp extends StatelessWidget {
  const SignUp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    bool validForm;
    SignUpForm signUpForm = new SignUpForm();
    ValueModel valueModel = new ValueModel();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 8, top: 32, right: 8, bottom: 32),
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
                    title: Text(IAMConstants.FORM_TITLE),
                    backgroundColor: Theme.of(context).accentColor,
                    centerTitle: true,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: TextFormField(
                      initialValue: '',
                      onChanged: (String value) async {
                        _checkValidUsername(value);
                      },
                      onSaved: (val) => signUpForm.userName = val.trim(),
                      validator: (String value) =>
                          _validateUserName(value.trim()),
                      decoration: InputDecoration(
                        labelText: IAMConstants.USERNAME,
                        hintText: IAMConstants.USERNAME_HINT,
                        icon: Icon(Icons.person),
                        isDense: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      initialValue: '',
                      onSaved: (val) => signUpForm.emailAddress = val.trim(),
                      validator: (val) => _validateEmail(val.trim()),
                      decoration: InputDecoration(
                        labelText: IAMConstants.EMAIL_ADDRESS,
                        hintText: IAMConstants.EMAIL_ADDRESS_HINT,
                        icon: Icon(Icons.email),
                        isDense: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: TextFormField(
                      obscureText: true,
                      initialValue: '',
                      onSaved: (val) => valueModel.value = val.trim(),
                      validator: (val) =>
                          val.length > 0 ? null : IAMConstants.INVALID_PASSWORD,
                      decoration: InputDecoration(
                        labelText: IAMConstants.PASSWORD,
                        hintText: IAMConstants.PASSWORD_HINT,
                        icon: Icon(Icons.payment),
                        isDense: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: TextFormField(
                      initialValue: '',
                      onSaved: (val) => signUpForm.firstName = val.trim(),
                      validator: (val) =>
                          val.trim().length > 0 && val.trim().length < 30
                              ? null
                              : IAMConstants.INVALID_FIRST_NAME,
                      decoration: InputDecoration(
                        labelText: IAMConstants.FIRST_NAME,
                        hintText: IAMConstants.FIRST_NAME_HINT,
                        icon: Icon(Icons.people),
                        isDense: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: TextFormField(
                      initialValue: '',
                      onSaved: (val) => signUpForm.middleName = val.trim(),
                      validator: (val) => _validateMiddleIntial(val.trim()),
                      decoration: InputDecoration(
                        labelText: IAMConstants.MIDDLE_INITIAL,
                        hintText: IAMConstants.MIDDLE_INITIAL_HINT,
                        icon: Icon(Icons.people),
                        isDense: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: TextFormField(
                      initialValue: '',
                      onSaved: (val) => signUpForm.lastName = val.trim(),
                      validator: (val) =>
                          val.trim().length > 0 && val.trim().length < 30
                              ? null
                              : IAMConstants.INVALID_LAST_NAME,
                      decoration: InputDecoration(
                        labelText: IAMConstants.LAST_NAME,
                        hintText: IAMConstants.LAST_NAME_HINT,
                        icon: Icon(Icons.people),
                        isDense: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      initialValue: '',
                      onSaved: (val) => signUpForm.phone = val.trim(),
                      validator: (val) => val.trim().length != 9
                          ? null
                          : IAMConstants.INVALID_PHONE,
                      decoration: InputDecoration(
                        labelText: IAMConstants.PHONE,
                        hintText: IAMConstants.PHONE_HINT,
                        icon: Icon(Icons.people),
                        isDense: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: new Center(
                      child: new ButtonBar(
                          mainAxisSize: MainAxisSize
                              .min, // this will take space as minimum as posible(to center)
                          children: <Widget>[
                            RaisedButton(
                              color: Theme.of(context).accentColor,
                              onPressed: () => {
                                validForm =
                                    FormUtils.validateCurrentForm(formKey),
                                _addCustomer(validForm, signUpForm, valueModel)
                                    .catchError((Object error) {
                                  FormUtils.showError(context, formKey);
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
      ),
    );
  }
}

bool _usernameTaken = false;
void _checkValidUsername(String value) async {
  CustomerClient client = new CustomerClient();
  client.checkUserName(value).then((value) => _usernameTaken = value);
}

String _validateUserName(String val) {
  if (val.length < 5 || val.length > 30) {
    return IAMConstants.INVALID_USERNAME_LENGTH;
  } else if (val.length == 0) {
    return IAMConstants.INVALID_USERNAME_LENGTH;
  }
  if (_usernameTaken) {
    return IAMConstants.USERNAME_TAKEN;
  }

  return null;
}

// validates that the email address is in the correct format and doesn't have a length of 0
String _validateEmail(String value) {
  if (!EmailValidator.validate(value)) {
    return IAMConstants.INVALID_EMAIL;
  } else if (value.length > 50) {
    return IAMConstants.INVALID_EMAIL_LENGTH;
  } else if (value.length == 0) {
    return IAMConstants.INVALID_EMAIL_REQUIRED;
  }

  return null;
}

String _validateMiddleIntial(String middleInitial) {
  if (middleInitial.length > 0) {
    if (middleInitial.length > 1) {
      return IAMConstants.INVALID_MIDDLE_INITIAL;
    }
  }
  return null;
}

Future<bool> _addCustomer(
    bool validForm, SignUpForm signUpForm, ValueModel valueModel) async {
  if (validForm) {
    CustomerClient customerClient = new CustomerClient();
    OktaClient oktaClient = new OktaClient();
    String customerResponse =
        await customerClient.addCustomer(jsonEncode(signUpForm.toJson()));
    log(customerResponse.toString());
    OktaForm request = _buildOktaForm(signUpForm, valueModel);
    String oktaResponse =
        await oktaClient.addUserToOkta(jsonEncode(request.toJson()));
    log(oktaResponse);
    return true;
  }
  return false;
}

_showSuccess(BuildContext context, GlobalKey<FormState> formKey) {
  final currentState = formKey.currentState;
  currentState.reset();
  showDialog(
    context: context,
    child: new AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      title: Text("Success"),
      content: Text(IAMConstants.REGISTRATION_SUCCESS),
      actions: [
        new FlatButton(
          child: const Text("Ok"),
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => new Splash()),
            ),
          },
        ),
      ],
    ),
  );
}

OktaForm _buildOktaForm(SignUpForm signUpForm, ValueModel valueModel) {
  OktaProfile profile = new OktaProfile(
      signUpForm.firstName,
      signUpForm.lastName,
      signUpForm.emailAddress,
      signUpForm.emailAddress,
      signUpForm.phone);
  return new OktaForm(profile, new OktaCredentials(valueModel));
}
