import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:main/theme/blossom_text.dart';

class ParseUtils {
  ParseUtils._();

  static Text parseAccountMask(String mask) {
    int length = mask.length;
    mask.replaceRange(0, length - 4, "X");
    return Text(mask, style: BlossomText.accountNumber);
  }

  static Text parseAvailableBalance(double balance) {
    var formatter = new NumberFormat("#,###.0#", "en_US");
    String formattedBalance = formatter.format(balance);
    return Text("\$" + formattedBalance, style: BlossomText.mediumBody);
  }
}
