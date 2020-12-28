import 'dart:developer' as logger;
import 'dart:math';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:main/client/accounts_client.dart';
import 'package:main/client/budget_client.dart';
import 'package:main/client/transactions_client.dart';
import 'package:main/components/drawer_container.dart';
import 'package:main/constants/budget_screen_constants.dart';
import 'package:main/constants/transaction_microservice_constants.dart';
import 'package:main/models/accounts/account_meta.dart';
import 'package:main/models/accounts/response/account_meta_response.dart';
import 'package:main/models/budget/getBudgetsResponse.dart';
import 'package:main/models/global/activeUser.dart';
import 'package:main/models/transactions/transactions_get_response.dart';
import 'package:main/screens/budgets_detail_screen.dart';
import 'package:main/screens/transaction_detail_screen.dart';
import 'package:main/theme/blossom_neumorphic_styles.dart';
import 'package:main/theme/blossom_neumorphic_text.dart';
import 'package:main/theme/blossom_spacing.dart';
import 'package:main/util/date_utils.dart';
import 'package:main/util/icon_util.dart';
import 'package:main/util/math_utils.dart';
import 'package:main/util/parse_utils.dart';
import 'package:main/widgets/nav_drawer.dart';
import 'package:scoped_model/scoped_model.dart';

class BudgetsScreen extends StatefulWidget {
  @override
  _BudgetsScreenState createState() => _BudgetsScreenState();
}

class _BudgetsScreenState extends State<BudgetsScreen> {
  final BudgetClient _budgetClient = BudgetClient();
  final TransactionsClient _transactionsClient = TransactionsClient();
  final AccountsClient _accountsClient = AccountsClient();
  AccountMetaResponse _metaResponse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          NavDrawer(),
          DrawerContainer(
            children: [
              FutureBuilder(
                future: _loadBudgets(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    //TODO: display toast
                    logger.log(snapshot.error);
                  }
                  if (snapshot.hasData) {
                    return Column(children: snapshot.data);
                  } else {
                    return Loading(indicator: BallPulseIndicator());
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<List<Widget>> _loadBudgets() async {
    final String phone =
        ScopedModel.of<ActiveUser>(context, rebuildOnChange: true).phone;
    GetBudgetsResponse budgetResponse = await _budgetClient.getBudgetsForUser(
        phone, DateUtils.currentFirstOfMonthIso());
    return await _buildBudgets(budgetResponse, phone);
  }

  Future<List<Widget>> _buildBudgets(
      GetBudgetsResponse budgetResponse, String phone) async {
    List<Widget> _budgetWidgets = new List();
    _budgetWidgets.add(NeumorphicText(BudgetScreenConstants.TITLE,
        textStyle: BlossomNeumorphicText.headline,
        style: BlossomNeumorphicStyles.eightGrey));
    _budgetWidgets.addAll(await _buildWidgetForBudgets(budgetResponse, phone));
    return _budgetWidgets;
  }

  Future<List<Widget>> _buildWidgetForBudgets(
      GetBudgetsResponse budgetResponse, String phone) async {
    List<Widget> widgets = new List();
    if (budgetResponse.budgets != null && budgetResponse.budgets.isNotEmpty) {
      TransactionsGetResponse response =
          await _getTransactionsForBudgets(phone);
      budgetResponse.budgets.forEach((budget) {
        final Icon iconData =
            IconUtil.determineIcon(ParseUtils.parseBudgetId(budget.id));
        List<Transactions> transactions =
            _filterTransactionsForBudget(response, budget.id);
        List<Transactions> transactionsSubSet;
        if (transactions.isNotEmpty) {
          transactionsSubSet =
              transactions.sublist(0, min(transactions.length, 10));
        } else {
          transactionsSubSet = List();
        }
        widgets.add(GestureDetector(
          onLongPress: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BudgetsDetailScreen(
                      budget, transactions, iconData, _metaResponse)),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Neumorphic(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  ExpandablePanel(
                    collapsed: _buildCollapsedWidgets(budget, iconData),
                    expanded: ExpandableButton(
                      child: Column(
                        children: [
                          _buildCollapsedWidgets(budget, iconData),
                          BlossomSpacing.STANDARD_FORM,
                          Row(
                            children: [
                              NeumorphicText(
                                BudgetScreenConstants.LEFT,
                                textStyle: BlossomNeumorphicText.secondaryBody,
                                style: BlossomNeumorphicStyles.fourGrey,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 8, right: 8)),
                              Neumorphic(
                                style: BlossomNeumorphicStyles
                                    .negativeEightConcaveWhite,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: NeumorphicText(
                                      MathUtils.getAvailableBalance(
                                          budget.allocation, budget.used),
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
                              Padding(
                                  padding: EdgeInsets.only(left: 8, right: 8)),
                              Neumorphic(
                                style: BlossomNeumorphicStyles
                                    .negativeEightConcaveWhite,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: NeumorphicText(
                                      ParseUtils.formatAmount(
                                          budget.allocation),
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
                                      minHeight: 180, maxHeight: 180),
                                  child: SingleChildScrollView(
                                    child: Column(
                                        children: _buildTransactionWidgets(
                                            transactionsSubSet)),
                                  ),
                                )
                              ],
                            ),
                            style: BlossomNeumorphicStyles
                                .negativeEightConcaveWhite,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: NeumorphicButton(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: NeumorphicText(
                                    BudgetScreenConstants.MORE_INFO,
                                    textStyle: BlossomNeumorphicText.body,
                                    style: BlossomNeumorphicStyles.fourGrey),
                              ),
                              style: BlossomNeumorphicStyles.fourButtonWhite,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BudgetsDetailScreen(
                                          budget,
                                          transactions,
                                          iconData,
                                          _metaResponse)),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ]),
              ),
              style: BlossomNeumorphicStyles.eightConcaveWhite,
            ),
          ),
        ));
      });
      return widgets;
    }
    widgets.add(Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: NeumorphicText(BudgetScreenConstants.NO_BUDGETS,
              textStyle: BlossomNeumorphicText.body,
              style: BlossomNeumorphicStyles.eightGrey),
        )
      ],
    ));
    return widgets;
  }

  Widget _buildGraphForBudget(double allocated, double used) {
    double percent = used / allocated;
    if (percent.isNegative) {
      percent = 0.00;
    }
    if (allocated == 0.00 && !used.isNegative) {
      percent = 1.00;
    }
    return SizedBox(
      width: 60,
      child: NeumorphicProgress(
          percent: percent, style: ProgressStyle(variant: Colors.green)),
    );
  }

  Widget _buildCollapsedWidgets(Budgets budget, Icon iconData) {
    final Widget graph = _buildGraphForBudget(budget.allocation, budget.used);
    return ExpandableButton(
      child: Neumorphic(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Neumorphic(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: NeumorphicIcon(iconData.icon,
                        style: BlossomNeumorphicStyles.twentyIconGrey),
                  ),
                  style: BlossomNeumorphicStyles.fourIconCircleWhite),
              Spacer(flex: 2),
              Column(
                children: [
                  NeumorphicText(ParseUtils.parseBudgetId(budget.id),
                      textStyle: BlossomNeumorphicText.largeBodyBold,
                      style: BlossomNeumorphicStyles.fourGrey),
                  // NeumorphicText(
                  //     "Left To Spend: " +
                  //         MathUtils.getAvailabileBalance(
                  //             budget.allocation, budget.used),
                  //     textStyle: BlossomNeumorphicText.body,
                  //     style: BlossomNeumorphicStyles.fourGrey),
                ],
              ),
              Spacer(flex: 2),
              graph
            ],
          ),
        ),
        style: BlossomNeumorphicStyles.negativeEightConcaveWhite,
      ),
    );
  }

  Future<TransactionsGetResponse> _getTransactionsForBudgets(
      String phone) async {
    _metaResponse = await _accountsClient.getAccountMetaDataForUser(phone);
    return await _transactionsClient.getTransactionsForUser(
        phone,
        TransactionsMicroserviceConstants.DATE_TIME_RANGE_QUERY,
        DateUtils.currentLastOfMonthIso(),
        DateUtils.currentDateIso());
  }

  List<Transactions> _filterTransactionsForBudget(
      TransactionsGetResponse response, String budgetId) {
    if (response.transactions != null && response.transactions.isNotEmpty) {
      return response.transactions
          .where((element) => element.budgetId == budgetId)
          .toList();
    }
    return List();
  }

  List<Widget> _buildTransactionWidgets(List<Transactions> transactionList) {
    List<Widget> transactionWidgets = new List();
    transactionWidgets.add(Divider());
    if (transactionList.isNotEmpty) {
      int i = 0;
      transactionList.forEach((transaction) {
        AccountMeta _currentMeta =
        ParseUtils.getCorrectMeta(_metaResponse, transaction.accountId);
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
    transactionWidgets.add(
        NeumorphicText(BudgetScreenConstants.NO_ASSOCIATED_TRANSACTIONS,
            textStyle: BlossomNeumorphicText.mediumBody,
            style: BlossomNeumorphicStyles.fourGrey)
    );
    return transactionWidgets;
  }
}
