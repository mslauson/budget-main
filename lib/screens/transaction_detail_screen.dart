import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:main/constants/transaction_page_constants.dart';
import 'package:main/models/accounts/account_meta.dart';
import 'package:main/models/transactions/transactions_get_response.dart';
import 'package:main/theme/blossom_neumorphic_styles.dart';
import 'package:main/theme/blossom_neumorphic_text.dart';
import 'package:main/util/parse_utils.dart';

class TransactionDetailScreen extends StatelessWidget {
  final Transactions _transaction;
  final AccountMeta _accountMeta;
  final Icon _icon;

  TransactionDetailScreen(this._transaction,this._accountMeta, this._icon);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Neumorphic(
        child: Padding(
          padding: EdgeInsets.only(top: 80, bottom: 50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Neumorphic(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: NeumorphicIcon(_icon.icon,
                            style: BlossomNeumorphicStyles.twentyIconGrey),
                      ),
                      style: BlossomNeumorphicStyles.fourIconCircle),
                   NeumorphicText(
                      ParseUtils.parseBudgetId(_transaction.budgetId),
                      textStyle: BlossomNeumorphicText.headline,
                      style: BlossomNeumorphicStyles.eightGrey)]),
              Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
              //Date
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Neumorphic(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: NeumorphicText(ParseUtils.formatDate(_transaction.date),
                            textStyle: BlossomNeumorphicText.largeBodyBold,
                            style: BlossomNeumorphicStyles.fourGrey),
                      ),
                      //Merchant
                      Padding(
                        padding: const EdgeInsets.only(left: 16,top: 8,bottom: 8, right: 16),
                        child: Row(
                          children: [
                            NeumorphicText(
                              TransactionsPageConstants.MERCHANT,
                              textStyle: BlossomNeumorphicText.secondaryBody,
                              style: BlossomNeumorphicStyles.fourGrey,
                            ),
                            Padding(padding: EdgeInsets.only(left: 2, right: 2)),
                            Expanded(
                              child: Neumorphic(
                                style: BlossomNeumorphicStyles.negativeEightConcave,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: NeumorphicText(
                                      _transaction.merchant,
                                      textStyle: BlossomNeumorphicText.body,
                                      style: BlossomNeumorphicStyles.fourGrey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Amount/account number
                      Padding(
                        padding: const EdgeInsets.only(left: 16,top: 8,bottom: 8, right: 16),
                        child: Row(
                          children: [
                            NeumorphicText(
                              TransactionsPageConstants.AMOUNT,
                              textStyle: BlossomNeumorphicText.secondaryBody,
                              style: BlossomNeumorphicStyles.fourGrey,
                            ),
                            Padding(padding: EdgeInsets.only(left: 2, right: 2)),
                            Expanded(
                              child: Neumorphic(
                                style: BlossomNeumorphicStyles.negativeEightConcave,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: NeumorphicText(
                                      ParseUtils.formatAmount(_transaction.amount),
                                      textStyle: BlossomNeumorphicText.body,
                                      style: BlossomNeumorphicStyles.fourGrey,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            NeumorphicText(
                              TransactionsPageConstants.ACCOUNT,
                              textStyle: BlossomNeumorphicText.secondaryBody,
                              style: BlossomNeumorphicStyles.fourGrey,
                            ),
                            Padding(padding: EdgeInsets.only(left: 2, right: 2)),
                            Expanded(
                              child: Neumorphic(
                                style: BlossomNeumorphicStyles.negativeEightConcave,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        NeumorphicText(_accountMeta.accountName,
                                            textStyle: BlossomNeumorphicText.body,
                                            style: BlossomNeumorphicStyles.fourGrey),
                                        Padding(padding: EdgeInsets.fromLTRB(5, 0, 5, 0)),
                                        NeumorphicText(_accountMeta.accountNumber,
                                            textStyle: BlossomNeumorphicText.accountNumber,
                                            style: BlossomNeumorphicStyles.fourGrey)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
