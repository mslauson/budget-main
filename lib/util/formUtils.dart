import 'package:flutter/material.dart';
import 'package:main/constants/globalConstants.dart';

class FormUtils{
    static bool validateCurrentForm(GlobalKey<FormState> formKey) {
    final currentState = formKey.currentState;
    if (currentState.validate()) {
      currentState.save();
      return true;
    }
    return false;
  }

    static showError(BuildContext context, GlobalKey<FormState> formKey, String message) {
    final currentState = formKey.currentState;
    currentState.reset();
    showDialog(
      context: context,
      child: new AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)), //this right here
        title: Text("Error"),
        content: Text(message + GlobalConstants.FAILURE_POPUP_DEFAULT),
        actions: [
          new FlatButton(
            child: const Text("Ok"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

}