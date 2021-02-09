import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
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
import 'package:main/theme/budget_icons.dart';
import 'package:main/util/parse_utils.dart';
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
          .where((transaction) => transaction.accountId == _account.id)
          .toList();
    }
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 80, bottom: 50),
        child: Neumorphic(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Neumorphic(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: NeumorphicIcon(BudgetIcons.BACK.icon,
                              style: BlossomNeumorphicStyles.twentyIconGrey),
                        ),
                        style: BlossomNeumorphicStyles.fourIconCircleWhite),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Neumorphic(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Image.memory(
                          base64Decode(_logo),
                          height: 40,
                          width: 40,
                        ),
                      ),
                      style: BlossomNeumorphicStyles.fourIconCircleWhite),
                  NeumorphicText(_account.name,
                      textStyle: BlossomNeumorphicText.title,
                      style: BlossomNeumorphicStyles.fourGrey),
                  ParseUtils.parseAccountMask(_account.mask),
                ],
              ),
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 8)),
                  NeumorphicText(AccountsPageConstants.AVAILABLE_BALANCE,
                      textStyle: BlossomNeumorphicText.body,
                      style: BlossomNeumorphicStyles.fourGrey),
                  Spacer(flex: 1),
                  Neumorphic(
                    style: BlossomNeumorphicStyles.negativeEightConcaveWhite,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: NeumorphicText(
                          ParseUtils.formatAmount(_account.balances.current),
                          textStyle: BlossomNeumorphicText.body,
                          style: BlossomNeumorphicStyles.fourGrey,
                        ),
                      ),
                    ),
                  ),
                  Spacer(flex: 4),
                ],
              ),
              BlossomSpacing.STANDARD_FORM,
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Neumorphic(
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
              ),
            ],
          ),
        ),
      ),
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
        AccountsPageConstants.NO_ASSOCIATED_TRANSACTIONS,
        textStyle: BlossomNeumorphicText.mediumBody,
        style: BlossomNeumorphicStyles.fourGrey));
    return transactionWidgets;
  }
}
