import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:main/components/drawer_container.dart';
import 'package:main/constants/accounts_page_constants.dart';
import 'package:main/constants/budget_screen_constants.dart';
import 'package:main/models/accounts/account.dart';
import 'package:main/models/accounts/account_meta.dart';
import 'package:main/models/accounts/response/account_meta_response.dart';
import 'package:main/models/global/activeUser.dart';
import 'package:main/models/transactions/transactions_get_response.dart';
import 'package:main/screens/transaction_detail_screen.dart';
import 'package:main/theme/blossom_neumorphic_styles.dart';
import 'package:main/theme/blossom_neumorphic_text.dart';
import 'package:main/theme/blossom_spacing.dart';
import 'package:main/util/parse_utils.dart';
import 'package:main/widgets/nav_drawer.dart';
import 'package:scoped_model/scoped_model.dart';

class AccountDetailScreen extends StatelessWidget {
  final Account _account;
  final String _logo;

  AccountDetailScreen(this._account, this._logo);

  @override
  Widget build(BuildContext context) {
    TransactionsGetResponse transactionsResponse =
        ScopedModel.of<ActiveUser>(context, rebuildOnChange: true).transactions;
    List<Transactions> transactions = List();
    if (transactionsResponse.transactions != null) {
      transactions = transactionsResponse.transactions
          .where((transaction) => transaction.accountId == _account.accountId);
    }
    return Scaffold(
      body: Stack(children: [
        NavDrawer(),
        DrawerContainer(children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.memory(
                    base64Decode(_logo),
                    height: 60,
                    width: 60,
                  ),
                  NeumorphicText(_account.name,
                      textStyle: BlossomNeumorphicText.title,
                      style: BlossomNeumorphicStyles.fourGrey),
                  ParseUtils.parseAccountMask(_account.mask),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Card(
                    margin: EdgeInsets.all(20),
                    child: ListTile(
                        title: NeumorphicText(
                            AccountsPageConstants.AVAILABLE_BALANCE,
                            textStyle: BlossomNeumorphicText.body,
                            style: BlossomNeumorphicStyles.fourGrey),
                        subtitle: NeumorphicText(
                            ParseUtils.formatAmount(_account.balances.current),
                            textStyle: BlossomNeumorphicText.body,
                            style: BlossomNeumorphicStyles.fourGrey))),
              ),
              BlossomSpacing.STANDARD_FORM,
              Neumorphic(
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 8)),
                    NeumorphicText(BudgetScreenConstants.RECENT_TRANSACTIONS,
                        textStyle: BlossomNeumorphicText.body,
                        style: BlossomNeumorphicStyles.fourGrey),
                    ConstrainedBox(
                      constraints:
                      BoxConstraints(minHeight: 275, maxHeight: 275),
                      child: SingleChildScrollView(
                        child: Column(
                            children: _buildTransactionWidgets(
                                transactions, context)),
                      ),
                    )
                  ],
                ),
                style: BlossomNeumorphicStyles.negativeEightConcaveWhite,
              ),
            ],
          ),
        ])
      ]),
    );
  }

  List<Widget> _buildTransactionWidgets(
      List<Transactions> transactionList, BuildContext context) {
    List<Widget> transactionWidgets = new List();
    transactionWidgets.add(Divider());
    if (transactionList.isNotEmpty) {
      int i = 0;
      transactionList.forEach((transaction) {
        AccountMetaResponse metaResponse =
            ScopedModel.of<ActiveUser>(context, rebuildOnChange: true).meta;
        AccountMeta _currentMeta =
            ParseUtils.getCorrectMeta(metaResponse, transaction.accountId);
        Icon iconData = ParseUtils.getIconForTransaction(transaction);
        transactionWidgets.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TransactionDetailScreen(
                        transaction, _currentMeta, iconData)),
              );
            },
            child: Row(
              children: [
                NeumorphicText(ParseUtils.parseMerchant(transaction.merchant),
                    textStyle: BlossomNeumorphicText.mediumBody,
                    style: BlossomNeumorphicStyles.fourGrey),
                Spacer(flex: 2),
                Neumorphic(
                  style: BlossomNeumorphicStyles.eightConcaveWhite,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
                    child: NeumorphicText(
                      ParseUtils.checkIfNegative(
                          ParseUtils.formatAmount(transaction.amount)),
                      textStyle: BlossomNeumorphicText.mediumBody,
                      style: BlossomNeumorphicStyles.fourGrey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
        if (i < transactionList.length - 1) {
          transactionWidgets.add(Divider());
          i++;
        }
      });
      return transactionWidgets;
    }
    transactionWidgets.add(NeumorphicText(
        BudgetScreenConstants.NO_ASSOCIATED_TRANSACTIONS,
        textStyle: BlossomNeumorphicText.mediumBody,
        style: BlossomNeumorphicStyles.fourGrey));
    return transactionWidgets;
  }
}
