import 'package:main/client/transactions_client.dart';
import 'package:main/models/plaid/response/plaid_transactions_response.dart';
import 'package:main/models/transactions/request/transactions_batch_request.dart';

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
}
