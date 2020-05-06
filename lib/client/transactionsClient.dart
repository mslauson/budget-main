import 'dart:convert';

import 'package:http/http.dart';
import 'package:main/constants/transactionsMicroserviceConstants.dart';
import 'package:main/error/errorHandler.dart';
import 'package:main/model/transactions/transactionsGetResponse.dart';

class TransactionsClient {
  static Future<TransactionsGetResponse> getAccountsForUser(String payload) async {
    Response response = await get(TransactionsMicroserviceConstants.TRANSACTIONS_URL + TransactionsMicroserviceConstants.GET_TRANSACTIONS_URI + payload);
    if(response.statusCode != 200){
      ErrorHandler.onError(response, "Account Retrieval");
    }
    return TransactionsGetResponse.fromJson(jsonDecode(response.body));
  }
}