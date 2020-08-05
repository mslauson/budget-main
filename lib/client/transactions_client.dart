import 'dart:convert';

import 'package:http/http.dart';
import 'package:main/constants/error_constants.dart';
import 'package:main/constants/transactionsMicroserviceConstants.dart';
import 'package:main/error/error_handler.dart';
import 'package:main/models/transactions/transactionsGetResponse.dart';

class TransactionsClient {
  static Future<TransactionsGetResponse> getTransactionsForUser(String email, String transactionQuery, String dateStart, String dateFinish) async {
    Response response = await get(
        TransactionsMicroserviceConstants.BASE_URL_TRANSACTIONS +
            TransactionsMicroserviceConstants.ENDPOINT_V1_TRANSACTIONS +
            "?email=" +
            email +
            "&transactionQuery=" +
            transactionQuery +
            "&dateStart=" +
            dateStart +
            "&dateFinish=" +
            dateFinish);
    if (response.statusCode != 200 && response.statusCode != 404) {
      ErrorHandler.onError(response, ErrorConstants.TRANSACTIONS_RETRIEVAL);
    }
    return TransactionsGetResponse.fromJson(jsonDecode(response.body));
  }
}