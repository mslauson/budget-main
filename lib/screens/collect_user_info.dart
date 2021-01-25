import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:main/components/icon_action_button.dart';
import 'package:main/constants/iam_constants.dart';
import 'package:main/models/iam/signUpForm.dart';
import 'package:main/screens/splash.dart';
import 'package:main/theme/blossom_neumorphic_styles.dart';
import 'package:main/theme/blossom_neumorphic_text.dart';
import 'package:main/theme/blossom_text.dart';

class CollectUserInfoScreen extends StatefulWidget {
  final String phone;
  final Function(SignUpForm signUpForm) onSubmit;

  CollectUserInfoScreen({this.phone, @required this.onSubmit});

  @override
  _CollectUserInfoScreenState createState() =>
      _CollectUserInfoScreenState(phone: phone, onSubmit: onSubmit);
}

class _CollectUserInfoScreenState extends State<CollectUserInfoScreen> {
  final String phone;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final Function(SignUpForm signUpForm) onSubmit;
  String _dob = "          ";
  String _isoDob = "";

  _CollectUserInfoScreenState({this.phone, @required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 50),
                Text(IAMConstants.FINAL_COLLECTION_HEADER,
                    style: BlossomText.title),
                const SizedBox(height: 25),
                TextFormField(
                    decoration: new InputDecoration(
                      labelText: IAMConstants.FULL_NAME_DECORATION,
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                    controller: _fullNameController,
                    validator: (val) => _validateName(val),
                    keyboardType: TextInputType.text,
                    style: BlossomText.body),
                const SizedBox(height: 25),
                TextFormField(
                    decoration: new InputDecoration(
                      labelText: IAMConstants.EMAIL_DECORATION,
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                    controller: _emailController,
                    validator: (val) => _validateEmail(val),
                    keyboardType: TextInputType.emailAddress,
                    style: BlossomText.body),
                const SizedBox(height: 25),
                Row(
                  children: [
                    NeumorphicText("Date Of Birth:",
                        textStyle: BlossomNeumorphicText.bodyBold,
                        style: BlossomNeumorphicStyles.eightGrey),
                    Padding(padding: EdgeInsets.only(right: 5, left: 5)),
                    GestureDetector(
                      onTap: () => {_showDatePicker(context)},
                      child: Neumorphic(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: NeumorphicText(_dob,
                              textStyle: BlossomNeumorphicText.body,
                              style: BlossomNeumorphicStyles.eightGrey),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildButtons(context),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<String> splitName(String fullName) {
    return fullName.split(" ");
  }

  _buildButtons(BuildContext context) {
    return <Widget>[
      IconActionButton(
          iconData: FontAwesomeIcons.arrowLeft,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Splash()),
          )),
      Padding(
        padding: EdgeInsets.fromLTRB(45, 0, 45, 0),
      ),
      IconActionButton(
          iconData: FontAwesomeIcons.arrowRight,
          onPressed: () => onSubmit(_buildSignUpForm()))
    ];
  }

  String _validateName(String val) {
    int temp = val.trim().indexOf(" ");
    if (val.length == 0) {
      return IAMConstants.INVALID_FULL_NAME;
    }
//                            else if (val.trim().indexOf(" ") != 1) {
//                              return "Please provide full name";
//                            }
    else {
      return null;
    }
  }

  String _validateEmail(String val) {
    if (val.length == 0) {
      return IAMConstants.INVALID_EMAIL_REQUIRED;
    } else if (!EmailValidator.validate(val)) {
      return IAMConstants.INVALID_EMAIL;
    } else {
      return null;
    }
  }

  SignUpForm _buildSignUpForm() {
    List<String> names = _fullNameController.text.trim().split(" ");
    SignUpForm signUpForm = new SignUpForm();
    signUpForm.phone = phone;
    signUpForm.emailAddress = _emailController.text.trim();
    signUpForm.firstName = names[0];
    signUpForm.lastName = names[1];
    signUpForm.dob = _isoDob;
    return signUpForm;
  }

  Future<void> _showDatePicker(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime selectedDate = DateTime(now.year - 16, now.month, now.day);
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1920),
        lastDate: selectedDate,
        initialEntryMode: DatePickerEntryMode.input,
        errorInvalidText: "Users Must be at least 16 years old to use BLSM.");
    final DateFormat usFormatter = DateFormat('MM/dd/yyyy');
    final DateFormat isoFormatter = DateFormat('yyyy-MM-dd');
    _isoDob = isoFormatter.format(picked);
    setState(() {
      _dob = usFormatter.format(picked);
    });
  }
}
