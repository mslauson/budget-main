import 'dart:convert';

import 'package:http/http.dart';
import 'package:main/constants/accountsMicroserviceConstants.dart';
import 'package:main/error/errorHandler.dart';
import 'package:main/model/accounts/getAccountsResponse.dart';

class AccountsClient{
  static Future<GetAccountsResponse> getAccountsForUser(String payload) async {
    Response response = await get(AccountsMicroserviceConstants.ACCOUNTS_BASE + AccountsMicroserviceConstants.ACCOUNTS_BASE_URI + payload);
    if(response.statusCode != 200){
      ErrorHandler.onError(response, "Account Retrieval");
    }
    return GetAccountsResponse.fromJson(jsonDecode(response.body));
  }
}