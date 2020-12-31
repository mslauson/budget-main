import 'package:main/client/transactions_client.dart';
import 'package:main/constants/transaction_microservice_constants.dart';
import 'package:main/models/plaid/response/plaid_transactions_response.dart';
import 'package:main/models/transactions/request/transactions_batch_request.dart';
import 'package:main/models/transactions/transactions_get_response.dart';
import 'package:main/util/date_utils.dart';

class TransactionsService {
  final TransactionsClient _transactionsClient = TransactionsClient();

  Future<void> addTransactions(
      PlaidTransactionsResponse transactionsResponse, String phone) async {
    TransactionsBatchRequest request =
        _buildBatchRequest(transactionsResponse, phone);
    await _transactionsClient.postTransactionBatch(request);
  }

  TransactionsBatchRequest _buildBatchRequest(
      PlaidTransactionsResponse transactionsResponse, String phone) {
    transactionsResponse.transactions.forEach((transaction) {
      transaction.phone = phone;
    });
    return TransactionsBatchRequest(
        transactions: transactionsResponse.transactions);
  }

  Future<TransactionsGetResponse> getTransactionsByPhone(String phone) async {
    return await _transactionsClient.getTransactionsForUser(
        phone,
        TransactionsMicroserviceConstants.DATE_TIME_RANGE_QUERY,
        DateUtils.currentLastOfMonthIso(),
        DateUtils.currentDateIso());
  }
}
