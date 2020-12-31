import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:main/client/accounts_client.dart';
import 'package:main/components/drawer_container.dart';
import 'package:main/models/accounts/account_meta.dart';
import 'package:main/models/accounts/response/account_meta_response.dart';
import 'package:main/models/global/activeUser.dart';
import 'package:main/models/transactions/transactions_get_response.dart';
import 'package:main/screens/transaction_detail_screen.dart';
import 'package:main/theme/blossom_neumorphic_styles.dart';
import 'package:main/theme/blossom_neumorphic_text.dart';
import 'package:main/theme/blossom_text.dart';
import 'package:main/util/parse_utils.dart';
import 'package:main/widgets/nav_drawer.dart';
import 'package:scoped_model/scoped_model.dart';

class TransactionsScreen extends StatefulWidget {
  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final AccountsClient _accountsClient = AccountsClient();
  AccountMetaResponse _metaResponse;

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
                if (snapshot.hasError) {
                  //TODO: display toast
                  log(snapshot.error);
                }
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
        ScopedModel.of<ActiveUser>(context, rebuildOnChange: true).transactions;
    _metaResponse = await _accountsClient.getAccountMetaDataForUser(phone);
    return await _buildTransactions(
        _getResponse, await _buildDateList(_getResponse));
  }

  Future<List<Widget>> _buildTransactions(
      TransactionsGetResponse getResponse, List<DateTime> dateList) async {
    List<Widget> _transactionWidgets = new List();
    _transactionWidgets.add(NeumorphicText('Transactions',
        textStyle: BlossomNeumorphicText.headline,
        style: BlossomNeumorphicStyles.eightGrey));
    dateList.forEach((date) async {
      List<Transactions> _transactionList = getResponse.transactions
          .where((transaction) => DateTime.parse(transaction.date) == date)
          .toList();
      List<Widget> _dateWidgets =
          await _buildTransactionsForADate(_transactionList);
      _transactionWidgets.add(Padding(
        padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
        child: Neumorphic(
          child: Column(children: _dateWidgets),
          style: BlossomNeumorphicStyles.eightConcaveWhite,
        ),
      ));
    });
    return _transactionWidgets;
  }

  Future<List<Widget>> _buildTransactionsForADate(
      List<Transactions> _transactions) async {
    List<Widget> _dateTransactions = new List();
    _dateTransactions.add(Padding(
      padding: const EdgeInsets.all(8),
      child: NeumorphicText(ParseUtils.formatDate(_transactions[0].date),
          textStyle: BlossomNeumorphicText.largeBodyBold,
          style: BlossomNeumorphicStyles.fourGrey),
    ));
    _transactions.forEach((transaction) {
      AccountMeta _currentMeta =
          ParseUtils.getCorrectMeta(_metaResponse, transaction.accountId);
      Icon iconData = ParseUtils.getIconForTransaction(transaction);
      _dateTransactions.add(
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
              child: Neumorphic(
                style: BlossomNeumorphicStyles.negativeEightConcaveWhite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: ListTile(
                        leading: Neumorphic(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: NeumorphicIcon(iconData.icon,
                                  style:
                                      BlossomNeumorphicStyles.twentyIconGrey),
                            ),
                            style: BlossomNeumorphicStyles.fourIconCircleWhite),
                        title: Text(
                          _subStrMerchant(transaction.merchant),
                          style: BlossomText.body,
                        ),
                        subtitle: Row(
                          children: [
                            Text(_currentMeta.accountName,
                                style: BlossomText.secondaryBody),
                            Padding(padding: EdgeInsets.fromLTRB(5, 0, 5, 0)),
                            Text(_currentMeta.accountNumber,
                                style: BlossomText.accountNumber)
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TransactionDetailScreen(
                                    transaction, _currentMeta, iconData)),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                      child: Neumorphic(
                        style: BlossomNeumorphicStyles.eightConcaveWhite,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
                          child: Text(
                            ParseUtils.checkIfNegative(
                                ParseUtils.formatAmount(transaction.amount)),
                            style: BlossomText.body,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
    _dateTransactions.add(Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
    ));
    return _dateTransactions;
  }

  Future<List<DateTime>> _buildDateList(
      TransactionsGetResponse response) async {
    List<DateTime> _dateList =
        response.transactions.map((e) => DateTime.parse(e.date)).toList();
    _dateList.sort((a, b) => b.compareTo(a));
    return _dateList.toSet().toList();
  }

  String _subStrMerchant(String merchant) {
    return merchant.length >= 25 ? merchant.substring(0, 25) : merchant;
  }
}
