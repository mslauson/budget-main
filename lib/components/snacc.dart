import 'package:flutter/material.dart';

class Snacc {
  Snacc._();

  static bar(BuildContext context, String message) {
    return Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
