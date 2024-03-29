import 'dart:convert';

import 'package:http/http.dart';
import 'package:main/constants/budget_client_constants.dart';
import 'package:main/constants/error_constants.dart';
import 'package:main/constants/global_constants.dart';
import 'package:main/error/error_handler.dart';
import 'package:main/models/budget/getBudgetsResponse.dart';
import 'package:main/models/budget/request/change_budget_request_model.dart';
import 'package:main/models/budget/response/initialize_customer_categories_response.dart';
import 'package:main/models/plaid/genericStatusResponseModel.dart';
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
    url = url + "?phone=" + encryptedPhone + "&monthYear=" + month;
    Response response = await get(url);
    if (response.statusCode != 200 && response.statusCode != 404) {
      ErrorHandler.onErrorClient(response, ErrorConstants.BUDGET_RETRIEVAL);
    }
    GetBudgetsResponse getBudgetsResponse =
        GetBudgetsResponse.fromJson(jsonDecode(response.body));
    return _modelEncryption.decryptGetBudgetsResponse(getBudgetsResponse);
  }

  Future<InitializeCustomerCategoriesResponse> initializeCategoriesForUser(
      String phone) async {
    String encryptedPhone = _encryptionUtility.encrypt(phone);
    encryptedPhone = Uri.encodeComponent(encryptedPhone);
    String url = UriBuilder.blossomDevWithUri(BudgetClientConstants.URI_BUDGETS,
        1, BudgetClientConstants.URI_PUT_INITIALIZE_CATEGORIES);
    url = url + "?phone=" + encryptedPhone;
    Response response = await put(url);
    if (response.statusCode != 200 && response.statusCode != 404) {
      ErrorHandler.onErrorClient(response, ErrorConstants.BUDGET_RETRIEVAL);
    }
    InitializeCustomerCategoriesResponse getBudgetsResponse =
        InitializeCustomerCategoriesResponse.fromJson(
            jsonDecode(response.body));
    return getBudgetsResponse;
  }

  Future<GenericSuccessResponseModel> changeBudgetForTransaction(
      ChangeBudgetRequestModel requestModel) async {
    String url = UriBuilder.blossomDevWithUri(BudgetClientConstants.URI_BUDGETS,
        1, BudgetClientConstants.URI_PUT_CHANGE_CATEGORIES);
    Response response = await put(url,
        headers: GlobalConstants.BASIC_POST_HEADERS,
        body: jsonEncode(requestModel.toJson()));
    if (response.statusCode != 200) {
      ErrorHandler.onErrorClient(response, ErrorConstants.BUDGET_RETRIEVAL);
    }
    GenericSuccessResponseModel changeBudgetResponse =
        GenericSuccessResponseModel.fromJson(jsonDecode(response.body));
    return changeBudgetResponse;
  }
}
