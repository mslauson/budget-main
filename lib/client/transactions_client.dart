import 'dart:convert';

import 'package:http/http.dart';
import 'package:main/constants/error_constants.dart';
import 'package:main/constants/global_constants.dart';
import 'package:main/constants/transaction_microservice_constants.dart';
import 'package:main/error/error_handler.dart';
import 'package:main/models/plaid/genericStatusResponseModel.dart';
import 'package:main/models/transactions/request/transaction_updates_request_model.dart';
import 'package:main/models/transactions/request/transactions_batch_request.dart';
import 'package:main/models/transactions/transactions_get_response.dart';
import 'package:main/util/uri_builder.dart';

class TransactionsClient {
  Future<TransactionsGetResponse> getTransactionsForUser(String phone,
      String transactionQuery, String dateStart, String dateFinish) async {
    Response response = await get(
        UriBuilder.blossomDev(TransactionsMicroserviceConstants.BASE_URI, 1) +
            "?phone=" +
            phone +
            "&transactionQuery=" +
            transactionQuery +
            "&dateStart=" +
            dateStart +
            "&dateFinish=" +
            dateFinish);
    if (response.statusCode != 200 && response.statusCode != 404) {
      ErrorHandler.onErrorClient(
          response, ErrorConstants.TRANSACTIONS_RETRIEVAL);
    }
    return TransactionsGetResponse.fromJson(jsonDecode(response.body));
  }

  Future<GenericSuccessResponseModel> postTransactionBatch(
      TransactionsBatchRequest batchRequest) async {
    Response response = await post(
        UriBuilder.blossomDevWithPath(
            TransactionsMicroserviceConstants.BASE_URI,
            1,
            TransactionsMicroserviceConstants.BATCH_URI),
        headers: GlobalConstants.BASIC_POST_HEADERS,
        body: jsonEncode(batchRequest.toJson()));
    if (response.statusCode != 200 && response.statusCode != 404) {
      ErrorHandler.onErrorClient(
          response, ErrorConstants.TRANSACTIONS_RETRIEVAL);
    }
    return GenericSuccessResponseModel.fromJson(jsonDecode(response.body));
  }

  Future<GenericSuccessResponseModel> updateTransaction(
      TransactionUpdatesRequestModel transactionUpdatesRequestModel) async {
    Response response = await put(
        UriBuilder.blossomDev(
            TransactionsMicroserviceConstants.BASE_URI,
            1),
        headers: GlobalConstants.BASIC_POST_HEADERS,
        body: jsonEncode(transactionUpdatesRequestModel.toJson()));
    if (response.statusCode != 200 && response.statusCode != 404) {
      ErrorHandler.onErrorClient(
          response, ErrorConstants.TRANSACTIONS_UPDATE);
    }
    return GenericSuccessResponseModel.fromJson(jsonDecode(response.body));
  }
}
