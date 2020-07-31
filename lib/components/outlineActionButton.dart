import 'package:flutter/material.dart';
import 'package:main/theme/blossomText.dart';

class OutlineActionButton extends StatelessWidget {
  final text;
  final color;
  final onPressed;

  OutlineActionButton(
      {Key key, @required this.text, this.color, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      onPressed: onPressed,
      borderSide: BorderSide(width: 2, color: color ?? Colors.black),
      child: Text(text, style: BlossomText.largeBody),
    );
  }
}
