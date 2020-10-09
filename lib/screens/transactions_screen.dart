import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:main/client/transactions_client.dart';
import 'package:main/components/drawer_container.dart';
import 'package:main/constants/transaction_microservice_constants.dart';
import 'package:main/models/global/activeUser.dart';
import 'package:main/models/transactions/transactions_get_response.dart';
import 'package:main/theme/blossom_text.dart';
import 'package:main/util/date_utils.dart';
import 'package:main/widgets/nav_drawer.dart';
import 'package:scoped_model/scoped_model.dart';

class TransactionsScreen extends StatefulWidget {
  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final TransactionsClient _transactionsClient = TransactionsClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          NavDrawer(),
          DrawerContainer(children: [
            FutureBuilder(
              future: _loadTransactions(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Column(children: snapshot.data);
                } else {
                  return Loading(indicator: BallPulseIndicator());
                }
              },
            ),
          ]),
        ],
      ),
    );
  }

  Future<List<Widget>> _loadTransactions() async {
    final String phone =
        ScopedModel.of<ActiveUser>(context, rebuildOnChange: true).phone;
    final TransactionsGetResponse _getResponse =
        await _transactionsClient.getTransactionsForUser(
            phone,
            TransactionsMicroserviceConstants.DATE_TIME_RANGE_QUERY,
            DateUtils.currentLastOfMonthIso(),
            DateUtils.currentDateIso());
    return await _buildTransactions(_getResponse, _buildDateList(_getResponse));
  }

  Future<List<Widget>> _buildTransactions(
      TransactionsGetResponse _getResponse, List<DateTime> _dateList) async {
    List<Widget> _transactionWidgets = new List();
    _transactionWidgets.add(Text('Transactions', style: BlossomText.headline));
    _dateList.forEach((date) {
      List<Transactions> _transactionList = _getResponse.transactions
          .where((transaction) => DateTime.parse(transaction.date) == date);
      _buildTransactionsForADate(_transactionList);
    });
    return _transactionWidgets;
  }

  Future<List<Widget>> _buildTransactionsForADate(
      List<Transactions> transactions) {}

  List<DateTime> _buildDateList(TransactionsGetResponse response) {
    List<DateTime> _dateList =
        response.transactions.map((e) => DateTime.parse(e.date));
    _dateList.sort((a, b) => a.compareTo(b));
    return _dateList;
  }
}

