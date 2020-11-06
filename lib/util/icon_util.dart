import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:main/constants/budget_icons_enum.dart';
import 'package:main/theme/budget_icons.dart';
import 'package:main/util/parse_utils.dart';

class IconUtil {
  IconUtil._();

  static Icon getIconByBudget(String budget, String subBudget) {
    String budgetId;
    if ((budget.contains("Payment") || budget.contains("Transfer")) &&
        !subBudget.contains("Deposit")) {
      budgetId = budget;
    } else {
      budgetId = subBudget != null ? subBudget : budgetId;
    }
    String budgetSubString = ParseUtils.parseBudgetId(budgetId);
    Icon icon = _determineIcon(budgetSubString);
    return icon;
  }

  static Icon _determineIcon(String budgetSubString) {
    BudgetIconsEnum currentEnum =
        EnumToString.fromString(BudgetIconsEnum.values, budgetSubString);
    switch (currentEnum) {
      case BudgetIconsEnum.Food:
        return BudgetIcons.FOOD;
      case BudgetIconsEnum.Travel:
        return BudgetIcons.TRAVEL;
      case BudgetIconsEnum.Airlines:
        return BudgetIcons.TRAVEL;
      case BudgetIconsEnum.Taxi:
        return BudgetIcons.TRANSPORTATION;
      case BudgetIconsEnum.Restaurants:
        return BudgetIcons.FOOD;
      case BudgetIconsEnum.Sporting:
        return BudgetIcons.SPORTS;
      case BudgetIconsEnum.Gyms:
        return BudgetIcons.GYM;
      case BudgetIconsEnum.Payment:
        return BudgetIcons.PAYMENT;
      case BudgetIconsEnum.Shops:
        return BudgetIcons.SHOPPING;
      case BudgetIconsEnum.Transfer:
        return BudgetIcons.TRANSFER;
      case BudgetIconsEnum.Deposit:
        return BudgetIcons.DEPOSIT;
      case BudgetIconsEnum.Recreation:
        return BudgetIcons.ENTERTAINMENT;
    }
    return null;
  }
}
