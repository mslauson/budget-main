import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:main/constants/transaction_page_constants.dart';
import 'package:main/models/accounts/account_meta.dart';
import 'package:main/models/transactions/transactions_get_response.dart';
import 'package:main/theme/blossom_neumorphic_styles.dart';
import 'package:main/theme/blossom_neumorphic_text.dart';
import 'package:main/theme/budget_icons.dart';
import 'package:main/util/parse_utils.dart';

class TransactionDetailScreen extends StatelessWidget {
  final Transactions _transaction;
  final AccountMeta _accountMeta;
  final Icon _icon;

  TransactionDetailScreen(this._transaction,this._accountMeta, this._icon);

  final TextEditingController _notesController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    _notesController.text=_transaction.notes;
    return Scaffold(
      body: Neumorphic(
        child: Padding(
          padding: EdgeInsets.only(top: 80, bottom: 50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(left: 24)),
                    GestureDetector(
                      child: Neumorphic(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: NeumorphicIcon(BudgetIcons.BACK.icon,
                                style: BlossomNeumorphicStyles.twentyIconGrey),
                          ),
                          style: BlossomNeumorphicStyles.fourIconCircle),
                      onTap: (){Navigator.of(context).pop();},
                    ),
                    Padding(padding: EdgeInsets.only(right: 16, left: 16)),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Neumorphic(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: NeumorphicIcon(_icon.icon,
                                      style: BlossomNeumorphicStyles.twentyIconGrey),
                                ),
                                style: BlossomNeumorphicStyles.fourIconCircle),
                            Padding(padding: EdgeInsets.only(right: 40, left: 40)),
                            NeumorphicText(ParseUtils.formatDate(_transaction.date),
                                textStyle: BlossomNeumorphicText.largeBodyBold,
                                style: BlossomNeumorphicStyles.fourGrey),
                          ],
                        ),
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
                      //Amount
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
                            Neumorphic(
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
                            )
                          ],
                        ),
                      ),
                      //Account information
                      Padding(
                        padding: const EdgeInsets.only(left: 16,top: 8,bottom: 8, right: 16),
                        child: Row(
                          children: [
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
                      //budget id
                      Padding(
                        padding: const EdgeInsets.only(left: 16,top: 8,bottom: 8, right: 16),
                        child: Row(
                          children: [
                            NeumorphicText(
                              TransactionsPageConstants.BUDGET,
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
                                    child: NeumorphicText(ParseUtils.parseBudgetId(_transaction.budgetId),
                                        textStyle: BlossomNeumorphicText.body,
                                        style: BlossomNeumorphicStyles.fourGrey),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Reimbursed
                      Padding(
                        padding: const EdgeInsets.only(left: 16,top: 8,bottom: 8, right: 16),
                        child: Row(
                          children: [
                            NeumorphicText(
                              TransactionsPageConstants.REIMBURSED,
                              textStyle: BlossomNeumorphicText.secondaryBody,
                              style: BlossomNeumorphicStyles.fourGrey,
                            ),
                            Padding(padding: EdgeInsets.only(left: 2, right: 2)),
                            NeumorphicCheckbox(value: false, onChanged: (value) {  },),
                          ],
                        ),
                      ),
                      //split
                      Padding(
                        padding: const EdgeInsets.only(left: 16,top: 8,bottom: 8, right: 16),
                        child: Row(
                          children: [
                            NeumorphicText(
                              TransactionsPageConstants.SPLIT,
                              textStyle: BlossomNeumorphicText.secondaryBody,
                              style: BlossomNeumorphicStyles.fourGrey,
                            ),
                            Padding(padding: EdgeInsets.only(left: 2, right: 2)),
                            NeumorphicCheckbox(value: false, onChanged: (value) {  },),
                          ],
                        ),
                      ),
                      //Notes
                      Padding(
                        padding: const EdgeInsets.only(left: 16,top: 8,bottom: 8, right: 16),
                        child: Column(
                          children: [
                            NeumorphicText(
                              TransactionsPageConstants.NOTES,
                              textStyle: BlossomNeumorphicText.secondaryBody,
                              style: BlossomNeumorphicStyles.fourGrey,
                            ),
                            Padding(padding: EdgeInsets.only(left: 2, right: 2)),
                            Neumorphic(
                              style: BlossomNeumorphicStyles.negativeEightConcave,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextField(
                                    autofocus: false,
                                    controller: _notesController,
                                    decoration: new InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        ),
                                    maxLines: null,
                                  )
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
