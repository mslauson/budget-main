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

  static String parseBudgetId(String budgetId) {
    String budgetSubString = budgetId.split(new RegExp(r"[0-9]"))[0];
    if (budgetSubString.indexOf(" ") >= 0) {
      budgetSubString = budgetSubString.split(" ")[0];
    }
    if (budgetSubString.indexOf("and") >= 0) {
      budgetSubString = budgetSubString.replaceAll("and", " & ");
    }
    return budgetSubString;
  }

  static String formatDate(String date){
    DateFormat dateFormatIso = DateFormat("yyyy-MM-dd");
    DateFormat dateFormatAmerican = DateFormat("MM/dd/yyyy");
    DateTime timestamp = dateFormatIso.parse(date);
    return dateFormatAmerican.format(timestamp);
  }

  static String formatAmount(double amount){
    return amount.toStringAsExponential(2);
  }
}
