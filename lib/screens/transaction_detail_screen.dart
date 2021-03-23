
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:main/client/budget_client.dart';
import 'package:main/client/transactions_client.dart';
import 'package:main/constants/transaction_page_constants.dart';
import 'package:main/models/accounts/account_meta.dart';
import 'package:main/models/budget/getBudgetsResponse.dart';
import 'package:main/models/budget/request/change_budget_request_model.dart';
import 'package:main/models/global/activeUser.dart';
import 'package:main/models/transactions/request/transaction_updates.dart';
import 'package:main/models/transactions/request/transaction_updates_request_model.dart';
import 'package:main/models/transactions/transactions_get_response.dart';
import 'package:main/theme/blossom_neumorphic_styles.dart';
import 'package:main/theme/blossom_neumorphic_text.dart';
import 'package:main/theme/budget_icons.dart';
import 'package:main/util/model_encryption_utility.dart';
import 'package:main/util/parse_utils.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class TransactionDetailScreen extends StatelessWidget {
  final Transactions _transaction;
  final AccountMeta _accountMeta;
  final Icon _icon;

  TransactionDetailScreen(this._transaction, this._accountMeta, this._icon);

  final TextEditingController _notesController = TextEditingController();
  final TransactionsClient _transactionsClient = TransactionsClient();
  final BudgetClient _budgetClient = BudgetClient();
  final PanelController _changeBudgetController = PanelController();
  final ModelEncryptionUtility _modelEncryptionUtility = ModelEncryptionUtility();

  @override
  Widget build(BuildContext context) {
    _notesController.text = _transaction.notes;
    final String _initialNote = _transaction.notes;
    return SlidingUpPanel(
      minHeight: 0,
      maxHeight: 250,
      controller: _changeBudgetController,
      panel: Neumorphic(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: NeumorphicText(TransactionsPageConstants.CHANGE_CATEGORY,
                  textStyle: BlossomNeumorphicText.secondaryBody,
                  style: BlossomNeumorphicStyles.eightGrey),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: 180, maxHeight: 180),
              child: SingleChildScrollView(
                child: Column(
                  children: _buildBudgetOptions(context),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Scaffold(
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
                          style: BlossomNeumorphicStyles.fourIconCircleWhite),
                      onTap: () {
                        _determineIfTransactionUpdated(_initialNote);
                        Navigator.of(context).pop();
                      },
                    ),
                    Padding(padding: EdgeInsets.only(right: 16, left: 16)),
                    NeumorphicText(
                        ParseUtils.parseBudgetId(_transaction.budgetId),
                        textStyle: BlossomNeumorphicText.headline,
                        style: BlossomNeumorphicStyles.eightGrey)
                  ]),
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
                                          style: BlossomNeumorphicStyles
                                              .twentyIconGrey),
                                    ),
                                    style: BlossomNeumorphicStyles
                                        .fourIconCircleWhite),
                                Padding(
                                    padding:
                                        EdgeInsets.only(right: 40, left: 40)),
                                NeumorphicText(
                                    ParseUtils.formatDate(_transaction.date),
                                    textStyle:
                                        BlossomNeumorphicText.largeBodyBold,
                                    style: BlossomNeumorphicStyles.fourGrey),
                              ],
                            ),
                          ),
                          //Merchant
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, top: 8, bottom: 8, right: 16),
                            child: Row(
                              children: [
                                NeumorphicText(
                                  TransactionsPageConstants.MERCHANT,
                                  textStyle:
                                      BlossomNeumorphicText.secondaryBody,
                                  style: BlossomNeumorphicStyles.fourGrey,
                                ),
                                Padding(
                                    padding:
                                        EdgeInsets.only(left: 2, right: 16)),
                                Expanded(
                                  child: Neumorphic(
                                    style: BlossomNeumorphicStyles
                                        .negativeEightConcaveWhite,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: NeumorphicText(
                                          _transaction.merchant,
                                          textStyle: BlossomNeumorphicText.body,
                                          style:
                                              BlossomNeumorphicStyles.fourGrey,
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
                            padding: const EdgeInsets.only(
                                left: 16, top: 8, bottom: 8, right: 16),
                            child: Row(
                              children: [
                                NeumorphicText(
                                  TransactionsPageConstants.AMOUNT,
                                  textStyle:
                                      BlossomNeumorphicText.secondaryBody,
                                  style: BlossomNeumorphicStyles.fourGrey,
                                ),
                                Padding(
                                    padding:
                                        EdgeInsets.only(left: 16, right: 16)),
                                Neumorphic(
                                  style: BlossomNeumorphicStyles
                                      .negativeEightConcaveWhite,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: NeumorphicText(
                                        ParseUtils.formatAmount(
                                            _transaction.amount),
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
                            padding: const EdgeInsets.only(
                                left: 16, top: 8, bottom: 8, right: 16),
                            child: Row(
                              children: [
                                NeumorphicText(
                                  TransactionsPageConstants.ACCOUNT,
                                  textStyle:
                                      BlossomNeumorphicText.secondaryBody,
                                  style: BlossomNeumorphicStyles.fourGrey,
                                ),
                                Padding(
                                    padding:
                                        EdgeInsets.only(left: 16, right: 15)),
                                Expanded(
                                  child: Neumorphic(
                                    style: BlossomNeumorphicStyles
                                        .negativeEightConcaveWhite,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            NeumorphicText(
                                                _accountMeta.accountName,
                                                textStyle:
                                                    BlossomNeumorphicText.body,
                                                style: BlossomNeumorphicStyles
                                                    .fourGrey),
                                            Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    5, 0, 5, 0)),
                                            NeumorphicText(
                                                _accountMeta.accountNumber,
                                                textStyle: BlossomNeumorphicText
                                                    .accountNumber,
                                                style: BlossomNeumorphicStyles
                                                    .fourGrey)
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
                            padding: const EdgeInsets.only(
                                left: 16, top: 8, bottom: 8, right: 16),
                            child: Row(
                              children: [
                                NeumorphicText(
                                  TransactionsPageConstants.BUDGET,
                                  textStyle:
                                      BlossomNeumorphicText.secondaryBody,
                                  style: BlossomNeumorphicStyles.fourGrey,
                                ),
                                Padding(
                                    padding:
                                        EdgeInsets.only(left: 18, right: 18)),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      _changeBudgetController.open();
                                    },
                                    child: Neumorphic(
                                      style: BlossomNeumorphicStyles
                                          .negativeEightConcaveWhite,
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: NeumorphicText(
                                              ParseUtils.parseBudgetId(
                                                  _transaction.budgetId),
                                              textStyle:
                                                  BlossomNeumorphicText.body,
                                              style: BlossomNeumorphicStyles
                                                  .fourGrey),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //Reimbursed
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, top: 8, bottom: 8, right: 16),
                            child: Row(
                              children: [
                                NeumorphicText(
                                  TransactionsPageConstants.REIMBURSED,
                                  textStyle:
                                      BlossomNeumorphicText.secondaryBody,
                                  style: BlossomNeumorphicStyles.fourGrey,
                                ),
                                Padding(
                                    padding:
                                        EdgeInsets.only(left: 4, right: 4)),
                                NeumorphicCheckbox(
                                  value: _determineBools(
                                      _transaction.reimbursement),
                                  onChanged: (value) {},
                                  style: NeumorphicCheckboxStyle(
                                      border:
                                          NeumorphicBorder(color: Colors.white),
                                      disabledColor: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          //split
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, top: 8, bottom: 8, right: 16),
                            child: Row(
                              children: [
                                NeumorphicText(
                                  TransactionsPageConstants.SPLIT,
                                  textStyle:
                                      BlossomNeumorphicText.secondaryBody,
                                  style: BlossomNeumorphicStyles.fourGrey,
                                ),
                                Padding(
                                    padding:
                                        EdgeInsets.only(left: 28, right: 28)),
                                NeumorphicCheckbox(
                                  value: false,
                                  onChanged: (value) {},
                                ),
                              ],
                            ),
                          ),
                          //Notes
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, top: 8, bottom: 32, right: 16),
                            child: Column(
                              children: [
                                NeumorphicText(
                                  TransactionsPageConstants.NOTES,
                                  textStyle:
                                      BlossomNeumorphicText.secondaryBody,
                                  style: BlossomNeumorphicStyles.fourGrey,
                                ),
                                Padding(
                                    padding:
                                        EdgeInsets.only(left: 2, right: 2)),
                                Neumorphic(
                                  style: BlossomNeumorphicStyles
                                      .negativeEightConcaveWhite,
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
                                            maxLines: null)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      style: BlossomNeumorphicStyles.standardBack,
                    ),
                  )
                ],
              ),
            ),
            style: BlossomNeumorphicStyles.standardBack,
          ),
        ),
      ),
    );
  }

  bool _determineBools(Object boolObject){
    return boolObject != null;
  }
  
  void _determineIfTransactionUpdated(String existingNote) {
    bool needsUpdating = (existingNote == null &&
        _notesController.text != "") ||
        (existingNote != null && _notesController.text == "");
    if (needsUpdating) {
      _updateTransaction(_notesController.text);
    }
  }

  Future<void> _updateTransaction(String notes) async {
    TransactionUpdates update = TransactionUpdates(
        notes: notes,
        transactionId: _transaction.transactionId,
        budget: _transaction.budgetId);
    await _transactionsClient.updateTransaction(
        TransactionUpdatesRequestModel(transactionUpdates: [update]));
  }

  List<Widget> _buildBudgetOptions(BuildContext context) {
    List<Widget> returnWidgets = new List();
    GetBudgetsResponse budgetResponse =
        ScopedModel.of<ActiveUser>(context, rebuildOnChange: true).budgets;
    List<String> budgetIds = budgetResponse.budgets.map((e) => e.id).toList();
    budgetIds.forEach((budgetId) {
      returnWidgets.add(GestureDetector(
        onTap: () {
          ChangeBudgetRequestModel changeBudgetRequestModel =
              _buildChangeBudgetRequest(context, _transaction.budgetId,
                  budgetId, _transaction.transactionId);
          _budgetClient.changeBudgetForTransaction(changeBudgetRequestModel);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Neumorphic(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: NeumorphicIcon(ParseUtils
                        .getIcon(budgetId)
                        .icon,
                        style: BlossomNeumorphicStyles.twentyIconGrey),
                  ),
                  style: BlossomNeumorphicStyles.fourIconCircleWhite),
              Spacer(
                flex: 1,
              ),
              NeumorphicText(ParseUtils.parseBudgetId(budgetId),
                  textStyle: BlossomNeumorphicText.body,
                  style: BlossomNeumorphicStyles.eightGrey),
              Spacer(
                flex: 1,
              )
            ],
          ),
        ),
      ));
    });
    return returnWidgets;
  }

  ChangeBudgetRequestModel _buildChangeBudgetRequest(BuildContext context,
      String currentBudget, String newBudget, String transactionId) {
    String phone =
        ScopedModel
            .of<ActiveUser>(context, rebuildOnChange: true)
            .phone;
    ChangeBudgetRequestModel requestModel = ChangeBudgetRequestModel(
        phone: phone,
        transactionId: transactionId,
        currentBudgetId: currentBudget,
        newBudgetId: newBudget
    );
    return _modelEncryptionUtility.encryptChangeBudgetRequest(requestModel);
  }
}
