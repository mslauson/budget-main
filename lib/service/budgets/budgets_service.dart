import 'package:main/client/budget_client.dart';
import 'package:main/models/budget/getBudgetsResponse.dart';
import 'package:main/util/date_utils.dart';

class BudgetsService {
  BudgetClient _budgetClient = BudgetClient();

  Future<GetBudgetsResponse> getBudgetsForUser(String phone) async {
    return await _budgetClient.getBudgetsForUser(
        phone, DateUtils.currentFirstOfMonthIso());
  }
}
