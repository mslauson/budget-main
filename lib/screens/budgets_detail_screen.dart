import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:main/constants/budget_screen_constants.dart';
import 'package:main/models/accounts/account_meta.dart';
import 'package:main/models/accounts/response/account_meta_response.dart';
import 'package:main/models/budget/getBudgetsResponse.dart';
import 'package:main/models/transactions/transactions_get_response.dart';
import 'package:main/screens/transaction_detail_screen.dart';
import 'package:main/theme/blossom_neumorphic_styles.dart';
import 'package:main/theme/blossom_neumorphic_text.dart';
import 'package:main/theme/blossom_spacing.dart';
import 'package:main/theme/budget_icons.dart';
import 'package:main/util/math_utils.dart';
import 'package:main/util/parse_utils.dart';

class BudgetsDetailScreen extends StatelessWidget {
  final Budgets _budget;
  final List<Transactions> _transactions;
  final AccountMetaResponse _accountMetaResponse;
  final Icon _icon;

  BudgetsDetailScreen(
      this._budget, this._transactions, this._icon, this._accountMetaResponse);

  final TextEditingController _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Neumorphic(
          child: Padding(
            padding: EdgeInsets.only(top: 80, bottom: 50),
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Padding(padding: EdgeInsets.only(left: 24)),
                  GestureDetector(
                    child: Neumorphic(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: NeumorphicIcon(BudgetIcons.BACK.icon,
                              style: BlossomNeumorphicStyles.twentyIconGrey),
                        ),
                        style: BlossomNeumorphicStyles.fourIconCircle),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Spacer(flex: 1),
                  NeumorphicText(ParseUtils.parseBudgetId(_budget.id),
                      textStyle: BlossomNeumorphicText.headline,
                      style: BlossomNeumorphicStyles.eightGrey),
                  Spacer(flex: 1),
                  Neumorphic(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: NeumorphicIcon(_icon.icon,
                            style: BlossomNeumorphicStyles.twentyIconGrey),
                      ),
                      style: BlossomNeumorphicStyles.fourIconCircle),
                  Padding(padding: EdgeInsets.only(right: 20)),
                ]),
                BlossomSpacing.STANDARD_FORM,
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          NeumorphicText(
                            BudgetScreenConstants.LEFT,
                            textStyle: BlossomNeumorphicText.secondaryBody,
                            style: BlossomNeumorphicStyles.fourGrey,
                          ),
                          Padding(padding: EdgeInsets.only(left: 8, right: 8)),
                          Neumorphic(
                            style: BlossomNeumorphicStyles.negativeEightConcave,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: NeumorphicText(
                                  MathUtils.getAvailableBalance(
                                      _budget.allocation, _budget.used),
                                  textStyle: BlossomNeumorphicText.body,
                                  style: BlossomNeumorphicStyles.fourGrey,
                                ),
                              ),
                            ),
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          NeumorphicText(
                            BudgetScreenConstants.ALLOCATED,
                            textStyle: BlossomNeumorphicText.secondaryBody,
                            style: BlossomNeumorphicStyles.fourGrey,
                          ),
                          Padding(padding: EdgeInsets.only(left: 8, right: 8)),
                          Neumorphic(
                            style: BlossomNeumorphicStyles.negativeEightConcave,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: NeumorphicText(
                                  ParseUtils.formatAmount(_budget.allocation),
                                  textStyle: BlossomNeumorphicText.body,
                                  style: BlossomNeumorphicStyles.fourGrey,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      BlossomSpacing.STANDARD_FORM,
                      Neumorphic(
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.only(top: 8)),
                            NeumorphicText(
                                BudgetScreenConstants.RECENT_TRANSACTIONS,
                                textStyle: BlossomNeumorphicText.body,
                                style: BlossomNeumorphicStyles.fourGrey),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                  minHeight: 275, maxHeight: 275),
                              child: SingleChildScrollView(
                                child: Column(
                                    children: _buildTransactionWidgets(
                                        _transactions, context)),
                              ),
                            )
                          ],
                        ),
                        style: BlossomNeumorphicStyles.negativeEightConcave,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTransactionWidgets(List<Transactions> transactionList,
      BuildContext context) {
    List<Widget> transactionWidgets = new List();
    transactionWidgets.add(Divider());
    if (transactionList.isNotEmpty) {
      int i = 0;
      transactionList.forEach((transaction) {
        AccountMeta _currentMeta =
        ParseUtils.getCorrectMeta(_accountMetaResponse, transaction.accountId);
        Icon iconData = ParseUtils.getIconForTransaction(transaction);
        transactionWidgets.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        TransactionDetailScreen(
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
                  style: BlossomNeumorphicStyles.eightConcave,
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
    transactionWidgets.add(
        NeumorphicText(BudgetScreenConstants.NO_ASSOCIATED_TRANSACTIONS,
            textStyle: BlossomNeumorphicText.mediumBody,
            style: BlossomNeumorphicStyles.fourGrey)
    );
    return transactionWidgets;
  }
}
