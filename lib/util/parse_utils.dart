import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:main/models/accounts/account_meta.dart';
import 'package:main/models/accounts/response/account_meta_response.dart';
import 'package:main/models/transactions/transactions_get_response.dart';
import 'package:main/theme/blossom_neumorphic_styles.dart';
import 'package:main/theme/blossom_neumorphic_text.dart';

import 'icon_util.dart';

class ParseUtils {
  ParseUtils._();

  static NeumorphicText parseAccountMask(String mask) {
    int length = mask.length;
    mask.replaceRange(0, length - 4, "X");
    return NeumorphicText(mask,
        textStyle: BlossomNeumorphicText.accountNumber,
        style: BlossomNeumorphicStyles.fourGrey);
  }

  static String parseMerchant(String merchant) {
    return merchant.substring(0, min(20, merchant.length));
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

  static String formatDate(String date) {
    DateFormat dateFormatIso = DateFormat("yyyy-MM-dd");
    DateFormat dateFormatAmerican = DateFormat("MM/dd/yyyy");
    DateTime timestamp = dateFormatIso.parse(date);
    return dateFormatAmerican.format(timestamp);
  }

  static String formatAmount(double amount) {
    return "\$" + amount.toStringAsFixed(2);
  }

  static String checkIfNegative(String amount) {
    if (amount.contains("-")) {
      amount = amount.replaceAll("-", "(");
      return amount + ")";
    }
    return amount;
  }

  static AccountMeta getCorrectMeta(AccountMetaResponse response, String accountId) {
    return response.accountMetaList
        .where((element) => element.accountId == accountId)
        .toList()[0];
  }

  static Icon getIconForTransaction(Transactions transaction) {
    return IconUtil.getIconByBudget(
        transaction.budgetId, transaction.subBudgetId);
  }
}
