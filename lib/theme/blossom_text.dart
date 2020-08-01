import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/theme/blossom_colors.dart';

class BlossomText {
  BlossomText._();

  static final headline = GoogleFonts.muli(
    fontSize: 36,
    fontWeight: FontWeight.w700,
  );
  static final title = GoogleFonts.lora(
    fontSize: 28,
    fontWeight: FontWeight.w500,
  );
  static final largeBody = GoogleFonts.imprima(
    fontSize: 22,
    fontWeight: FontWeight.w300,
  );
  static final body = GoogleFonts.imprima(
    fontSize: 18,
    fontWeight: FontWeight.w300,
  );
  static final secondaryBody = GoogleFonts.imprima(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: BlossomColors.darkAccent,
  );
}
