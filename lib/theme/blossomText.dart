import 'package:flutter/painting.dart';
import 'package:main/theme/blossomColors.dart';

class BlossomText {
  static final headline = TextStyle(
    fontFamily: _textGeorgia,
    fontSize: 28,
    fontWeight: FontWeight.w600,
  );
  static final title = TextStyle(
    fontFamily: _textSegoeUi,
    fontSize: 20,
    fontWeight: FontWeight.w300,
  );
  static final largeBody = TextStyle(
    fontFamily: _textSegoeUi,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  static final body = TextStyle(
    fontFamily: _textSegoeUi,
    fontSize: 14,
    fontWeight: FontWeight.w300,
  );
  static final secondaryBody = TextStyle(
    fontFamily: _textSegoeUi,
    fontSize: 12,
    color: BlossomColors.darkAccent,
    fontWeight: FontWeight.w400,
  );

  static final _textSegoeUi = 'Segoe UI';
  static final _textGeorgia = 'Georgia';
}
