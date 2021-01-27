import 'dart:convert';

import 'package:http/http.dart';
import 'package:main/constants/budget_client_constants.dart';
import 'package:main/constants/error_constants.dart';
import 'package:main/error/error_handler.dart';
import 'package:main/models/budget/getBudgetsResponse.dart';
import 'package:main/security/blossom_encryption_utility.dart';
import 'package:main/util/model_encryption_utility.dart';
import 'package:main/util/uri_builder.dart';

class BudgetClient {
  final _modelEncryption = ModelEncryptionUtility();
  final _encryptionUtility = BlossomEncryptionUtility();

  Future<GetBudgetsResponse> getBudgetsForUser(
      String phone, String month) async {
    String encryptedPhone = _encryptionUtility.encrypt(phone);
    encryptedPhone = Uri.encodeComponent(encryptedPhone);
    String url = UriBuilder.blossomDevWithUri(BudgetClientConstants.URI_BUDGETS,
        1, BudgetClientConstants.URI_GET_BUDGETS_MONTH);
    url = url + "?phone=" + encryptedPhone + "?monthYear=" + month;
    Response response = await get(url);
    if (response.statusCode != 200 && response.statusCode != 404) {
      ErrorHandler.onErrorClient(response, ErrorConstants.BUDGET_RETRIEVAL);
    }
    GetBudgetsResponse getBudgetsResponse =
        GetBudgetsResponse.fromJson(jsonDecode(response.body));
    return _modelEncryption.decryptGetBudgetsResponse(getBudgetsResponse);
  }
}
