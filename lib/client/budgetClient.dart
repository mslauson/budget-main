import 'dart:convert';

import 'package:http/http.dart';
import 'package:main/constants/budgetClientConstants.dart';
import 'package:main/error/errorHandler.dart';
import 'package:main/model/budget/getBudgetsResponse.dart';

class BudgetClient {
  static Future<GetBudgetsResponse> getBudgetsForUser(
      String email, String month) async {
    Response response = await get(BudgetClientConstants.BASE_URL +
        BudgetClientConstants.BASE_URI +
        email +
        BudgetClientConstants.MONTH_URI +
        month);
    if (response.statusCode != 200 && response.statusCode != 404) {
      ErrorHandler.onError(response, "Budget Retrieval");
    }
    return GetBudgetsResponse.fromJson(jsonDecode(response.body));
  }
}
