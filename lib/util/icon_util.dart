import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:main/constants/budget_icons_enum.dart';
import 'package:main/theme/budget_icons.dart';

class IconUtil {
  Icon determineIcon(String budget) {
    BudgetIconsEnum currentEnum =
        EnumToString.fromString(BudgetIconsEnum.values, budget);
    switch (currentEnum) {
      case BudgetIconsEnum.Food:
        return BudgetIcons.FOOD;
      case BudgetIconsEnum.Travel:
        return BudgetIcons.TRAVEL;
      case BudgetIconsEnum.Restaurants:
        return BudgetIcons.FOOD;
      case BudgetIconsEnum.Sporting:
        return BudgetIcons.SPORTS;
      case BudgetIconsEnum.Payment:
        return BudgetIcons.PAYMENT;
      case BudgetIconsEnum.Shops:
        return BudgetIcons.SHOPPING;
      case BudgetIconsEnum.Transfer:
        return BudgetIcons.TRANSFER;
      case BudgetIconsEnum.Recreation:
        return BudgetIcons.ENTERTAINMENT;
    }
    return null;
  }
}
