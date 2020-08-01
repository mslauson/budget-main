import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:main/components/outline_action_button.dart';
import 'package:main/components/snacc.dart';
import 'package:main/constants/global_constants.dart';
import 'package:main/service/auth/authenticationService.dart';
import 'package:main/theme/blossom_text.dart';

class PhoneInputForm extends StatefulWidget {
  @override
  PhoneInputFormState createState() => PhoneInputFormState();
}

class PhoneInputFormState extends State<PhoneInputForm> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  final _authService = new AuthenticationService(false, null);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _paintSignInWithPhone(context),
            Spacer(flex: 1),
            _paintPhoneInput(),
          ],
        ),
      ),
    );
  }

  Widget _paintSignInWithPhone(BuildContext context) => OutlineActionButton(
        text: "Continue with Phone",
        onPressed: () => _onSubmit(),
      );

  Widget _paintPhoneInput() => Container(
        width: 250,
        child: InternationalPhoneNumberInput(
          initialValue: PhoneNumber(
            isoCode: GlobalConstants.countryCodes[0],
          ),
          countries: GlobalConstants.countryCodes,
          onInputValidated: (valid) => _handleInputValidated(valid),
          hintText: 'Mobile Number',
          inputBorder: OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide(),
          ),
          selectorTextStyle: TextStyle(color: Colors.black),
          textFieldController: _controller,
          textStyle: BlossomText.body,
        ),
      );

  void _onSubmit() {
    bool isValid = _formKey.currentState.validate();
    if (isValid) _handleSuccess();
    if (!isValid) _handleError();
  }

  void _handleSuccess() {
    _authService.authenticateUser(
        _controller.text.replaceAll('-', ''), context);
  }

  void _handleError() {
    Snacc.bar(context, 'Please enter a valid phone number');
  }

  void _handleInputValidated(bool valid) {
    if (valid) {
      _handleSuccess();
    }
  }
}
