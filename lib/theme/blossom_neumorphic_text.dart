import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

/// With the Neumorphic Framework, we have to specify the color in the text
/// widget itself
class BlossomNeumorphicText {
  BlossomNeumorphicText._();

  static final headline = NeumorphicTextStyle(
      fontSize: 36, fontWeight: FontWeight.w700, fontFamily: 'Neuton');

  static final title = NeumorphicTextStyle(
      fontSize: 32, fontWeight: FontWeight.w500, fontFamily: 'Mulish');

  static final largeBody = NeumorphicTextStyle(
      fontSize: 22, fontWeight: FontWeight.w300, fontFamily: 'Imprima');

  static final largeBodyBold = NeumorphicTextStyle(
      fontSize: 22, fontWeight: FontWeight.w500, fontFamily: 'Imprima');

  static final body = NeumorphicTextStyle(
      fontSize: 18, fontWeight: FontWeight.w300, fontFamily: 'Imprima');

  static final mediumBody = NeumorphicTextStyle(
      fontSize: 16, fontWeight: FontWeight.w300, fontFamily: 'Imprima');

  static final secondaryBody = NeumorphicTextStyle(
      fontSize: 14, fontWeight: FontWeight.w300, fontFamily: 'Imprima');

  static final accountNumber = NeumorphicTextStyle(
      fontSize: 14, fontWeight: FontWeight.w900, fontFamily: 'Orbitron');
}
