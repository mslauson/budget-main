import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:main/constants/budget_icons_enum.dart';
import 'package:main/theme/budget_icons.dart';

class IconUtil {
  IconUtil._();

  static Icon getIconByBudget(String category) {
    String budgetCategory;
    budgetCategory = category.replaceAll(" & ", "And");
    budgetCategory = budgetCategory.replaceAll(" ", "");
    Icon icon = determineIcon(budgetCategory);
    return icon;
  }

  static Icon determineIcon(String budgetCategory) {
    BudgetIconsEnum currentEnum =
        EnumToString.fromString(BudgetIconsEnum.values, budgetCategory);
    switch (currentEnum) {
      case BudgetIconsEnum.Cash:
        return BudgetIcons.CASH;
      case BudgetIconsEnum.BillsAndUtilities:
        return BudgetIcons.BILLS;
      case BudgetIconsEnum.BusinessExpenses:
        return BudgetIcons.BUSINESS;
      case BudgetIconsEnum.Education:
        return BudgetIcons.EDUCATION;
      case BudgetIconsEnum.Entertainment:
        return BudgetIcons.ENTERTAINMENT;
      case BudgetIconsEnum.BankFees:
        return BudgetIcons.FEE;
      case BudgetIconsEnum.Gifts:
        return BudgetIcons.GIFT;
      case BudgetIconsEnum.Groceries:
        return BudgetIcons.GROCERIES;
      case BudgetIconsEnum.Home:
        return BudgetIcons.HOME;
      case BudgetIconsEnum.Income:
        return BudgetIcons.INCOME;
      case BudgetIconsEnum.Investments:
        return BudgetIcons.INVEST;
      case BudgetIconsEnum.Loans:
        return BudgetIcons.LOANS;
      case BudgetIconsEnum.MedicalExpenses:
        return BudgetIcons.MEDICAL;
      case BudgetIconsEnum.Other:
        return BudgetIcons.OTHER;
      case BudgetIconsEnum.Pets:
        return BudgetIcons.PETS;
      case BudgetIconsEnum.RestaurantsAndBars:
        return BudgetIcons.RESTAURANT;
      case BudgetIconsEnum.SelfCare:
        return BudgetIcons.SPA;
      case BudgetIconsEnum.Shopping:
        return BudgetIcons.SHOPPING;
      case BudgetIconsEnum.Subscription:
        return BudgetIcons.SUBSCRIPTION;
      case BudgetIconsEnum.Taxes:
        return BudgetIcons.TAXES;
      case BudgetIconsEnum.Transfers:
        return BudgetIcons.TRANSFER;
      case BudgetIconsEnum.Transportation:
        return BudgetIcons.TRANSPORTATION;
      case BudgetIconsEnum.Vacation:
        return BudgetIcons.VACATION;
    }
    return null;
  }
}
