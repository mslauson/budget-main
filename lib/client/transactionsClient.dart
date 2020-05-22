import 'dart:convert';

import 'package:http/http.dart';
import 'package:main/constants/transactionsMicroserviceConstants.dart';
import 'package:main/error/errorHandler.dart';
import 'package:main/model/transactions/transactionsGetResponse.dart';

class TransactionsClient {
  static Future<TransactionsGetResponse> getTransactionsForUser(String email, String transactionQuery, String dateStart, String dateFinish) async {
    Response response = await get(TransactionsMicroserviceConstants.TRANSACTIONS_URL
        + TransactionsMicroserviceConstants.GET_TRANSACTIONS_URI
        +"?email=" + email
      +  "&transactionQuery=" + transactionQuery
    +"&dateStart="+dateStart
    +"&dateFinish="+ dateFinish);
    if(response.statusCode != 200 && response.statusCode != 404){
      ErrorHandler.onError(response, "Transaction Retrieval");
    }
    return TransactionsGetResponse.fromJson(jsonDecode(response.body));
  }
}