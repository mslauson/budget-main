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
import 'package:main/security/blossom_encryption_utility.dart';
import 'package:main/util/model_encryption_utility.dart';
import 'package:main/util/uri_builder.dart';

class TransactionsClient {
  final _modelEncryption = ModelEncryptionUtility();
  final _encryptionUtility = BlossomEncryptionUtility();

  Future<TransactionsGetResponse> getTransactionsForUser(String phone,
      String transactionQuery, String dateStart, String dateFinish) async {
    String encryptedPhone = _encryptionUtility.encrypt(phone);
    encryptedPhone = Uri.encodeComponent(encryptedPhone);
    Response response = await get(
        UriBuilder.blossomDev(TransactionsMicroserviceConstants.BASE_URI, 1) +
            "?phone=" +
            encryptedPhone +
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

    TransactionsGetResponse transactionsGetResponse =
        TransactionsGetResponse.fromJson(jsonDecode(response.body));
    return _modelEncryption
        .decryptTransactionsGetResponse(transactionsGetResponse);
  }

  //currently not being used
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
    TransactionUpdatesRequestModel encryptedModel = _modelEncryption
        .encryptTransactionUpdatesRequestModel(transactionUpdatesRequestModel);
    Response response = await put(
        UriBuilder.blossomDev(TransactionsMicroserviceConstants.BASE_URI, 1),
        headers: GlobalConstants.BASIC_POST_HEADERS,
        body: jsonEncode(transactionUpdatesRequestModel.toJson()));
    if (response.statusCode != 200 && response.statusCode != 404) {
      ErrorHandler.onErrorClient(response, ErrorConstants.TRANSACTIONS_UPDATE);
    }
    return GenericSuccessResponseModel.fromJson(jsonDecode(response.body));
  }

  Future<GenericSuccessResponseModel> deleteTransactions(String phone, String itemId) async {
    String encryptedPhone = _encryptionUtility.encrypt(phone);
    encryptedPhone = Uri.encodeComponent(encryptedPhone);
    String encryptedItemId = _encryptionUtility.encrypt(itemId);
    encryptedItemId = Uri.encodeComponent(encryptedItemId);
    Response response = await delete(
        UriBuilder.blossomDevWithTwoPath(
            TransactionsMicroserviceConstants.BASE_URI,
            1,
            encryptedPhone,
            encryptedItemId),
        headers: GlobalConstants.BASIC_POST_HEADERS);
    if (response.statusCode != 200 && response.statusCode != 404) {
      ErrorHandler.onErrorClient(response, ErrorConstants.TRANSACTIONS_REMOVAL);
    }
    return GenericSuccessResponseModel.fromJson(jsonDecode(response.body));
  }
}
