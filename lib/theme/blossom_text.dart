import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/theme/blossom_colors.dart';

class BlossomText {
  BlossomText._();

  static final headline = GoogleFonts.neuton(
    fontSize: 36,
    fontWeight: FontWeight.w700,
  );
  static final headlineLight = GoogleFonts.neuton(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );
  static final title = GoogleFonts.muli(
    fontSize: 32,
    fontWeight: FontWeight.w500,
  );
  static final titleLight = GoogleFonts.muli(
    fontSize: 32,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
  static final largeBody = GoogleFonts.imprima(
    fontSize: 22,
    fontWeight: FontWeight.w300,
  );
  static final largeBodyLight = GoogleFonts.imprima(
    fontSize: 22,
    fontWeight: FontWeight.w300,
    color: Colors.white,
  );
  static final body = GoogleFonts.imprima(
    fontSize: 18,
    fontWeight: FontWeight.w300,
  );
  static final bodyLight = GoogleFonts.imprima(
    fontSize: 18,
    fontWeight: FontWeight.w300,
    color: Colors.white,
  );
  static final secondaryBody = GoogleFonts.imprima(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: BlossomColors.darkAccent,
  );
  static final secondaryBodyLight = GoogleFonts.imprima(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: BlossomColors.lightAccent,
  );
}
