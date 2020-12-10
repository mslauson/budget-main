import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:main/models/accounts/account_meta.dart';
import 'package:main/models/budget/getBudgetsResponse.dart';
import 'package:main/models/transactions/transactions_get_response.dart';
import 'package:main/theme/blossom_neumorphic_styles.dart';
import 'package:main/theme/blossom_neumorphic_text.dart';
import 'package:main/theme/budget_icons.dart';
import 'package:main/util/parse_utils.dart';

class BudgetsDetailScreen {
  final Budgets _budget;
  final List<Transactions> _transactions;
  final AccountMeta _accountMeta;
  final Icon _icon;

  BudgetsDetailScreen(
      this._budget, this._transactions, this._accountMeta, this._icon);

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
                  Padding(padding: EdgeInsets.only(right: 16, left: 16)),
                  NeumorphicText(ParseUtils.parseBudgetId(_budget.id),
                      textStyle: BlossomNeumorphicText.headline,
                      style: BlossomNeumorphicStyles.eightGrey),
                  Neumorphic(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: NeumorphicIcon(_icon.icon,
                            style: BlossomNeumorphicStyles.twentyIconGrey),
                      ),
                      style: BlossomNeumorphicStyles.fourIconCircle)
                ]),
                Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
              ],
            ),
          ),
        ),
      ),
    );
  }

// bool _determineBools(Object boolObject){
//   return boolObject != null;
// }
//
// void _determineIfTransactionUpdated(String existingNote){
//   bool needsUpdating = (existingNote == null && _notesController.text != "") || (existingNote != null && _notesController.text == "");
//   if(needsUpdating){
//     _updateTransaction(_notesController.text);
//   }
// }
//
// Future<void> _updateTransaction(String notes) async {
//   TransactionUpdates update = TransactionUpdates(notes: notes, transactionId: _transaction.transactionId, budget: _transaction.budgetId);
//   await _transactionsClient.updateTransaction(TransactionUpdatesRequestModel(transactionUpdates: [update]));
// }
}
