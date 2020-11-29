import 'dart:developer';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:main/client/budget_client.dart';
import 'package:main/client/transactions_client.dart';
import 'package:main/components/drawer_container.dart';
import 'package:main/constants/budget_screen_constants.dart';
import 'package:main/constants/transaction_microservice_constants.dart';
import 'package:main/models/budget/getBudgetsResponse.dart';
import 'package:main/models/global/activeUser.dart';
import 'package:main/models/transactions/transactions_get_response.dart';
import 'package:main/theme/blossom_neumorphic_styles.dart';
import 'package:main/theme/blossom_neumorphic_text.dart';
import 'package:main/util/date_utils.dart';
import 'package:main/util/icon_util.dart';
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
                    log(snapshot.error);
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
    return await _buidBudgets(budgetResponse, phone);
  }

  Future<List<Widget>> _buidBudgets(
      GetBudgetsResponse budgetResponse, String phone) async {
    List<Widget> _budgetWidgets = new List();
    _budgetWidgets.add(NeumorphicText('Budgets',
        textStyle: BlossomNeumorphicText.headline,
        style: BlossomNeumorphicStyles.eightGrey));
    _budgetWidgets.addAll(await _buildWidgetForBudgets(budgetResponse, phone));
    return _budgetWidgets;
  }

  Future<List<Widget>> _buildWidgetForBudgets(GetBudgetsResponse budgetResponse,
      String phone) async {
    List<Widget> widgets = new List();
    TransactionsGetResponse response = await _getTransactionsForBudgets(phone);
    budgetResponse.budgets.forEach((budget) {
      List<Transactions> transactions = _filterTransactionsForBudget(
          response, budget.id);
      List<Transactions> transactionsSubSet = transactions.sublist(0, 3);
      widgets.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Neumorphic(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              ExpandablePanel(
                collapsed: _buildCollapsedWidgets(budget),
                expanded: ExpandableButton(
                  child: Column(
                    children: [
                      _buildCollapsedWidgets(budget),
                      Padding(padding: EdgeInsets.only(top: 5, bottom: 5)),
                      Neumorphic(
                        child: Column(
                          children: [
                            NeumorphicText(
                                BudgetScreenConstants.RECENT_TRANSACTIONS,
                                textStyle: BlossomNeumorphicText.body,
                                style: BlossomNeumorphicStyles.fourGrey),
                            Row(
                              children: [
                              ],
                            )
                          ],
                        ),
                        style: BlossomNeumorphicStyles.negativeEightConcave,
                      ),
                    ],
                  ),
                ),
              )
            ]),
          ),
          style: BlossomNeumorphicStyles.eightConcave,
        ),
      ));
    });
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

  Widget _buildCollapsedWidgets(Budgets budget) {
    final Icon iconData =
        IconUtil.determineIcon(ParseUtils.parseBudgetId(budget.id));
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
                  style: BlossomNeumorphicStyles.fourIconCircle),
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
        style: BlossomNeumorphicStyles.negativeEightConcave,
      ),
    );
  }

  Future<TransactionsGetResponse> _getTransactionsForBudgets(
      String phone) async {
    return await _transactionsClient.getTransactionsForUser(
        phone,
        TransactionsMicroserviceConstants.DATE_TIME_RANGE_QUERY,
        DateUtils.currentLastOfMonthIso(),
        DateUtils.currentDateIso());
  }

  List<Transactions> _filterTransactionsForBudget(
      TransactionsGetResponse response, String budgetId) {
    return response.transactions.where((element) =>
    element.budgetId == budgetId).toList();
  }

  List<Widget> _buidTransactionWidgets(List<Transactions> transactionList) {
    List<Widget> transactionWidgets = new List();
    transactionList.forEach((transaction) {
      transactionWidgets.add(
          Row(
            children: [
              NeumorphicText(transaction.merchant,
                  textStyle: BlossomNeumorphicText.mediumBody,
                  style: BlossomNeumorphicStyles.fourGrey),
              Spacer(flex: 2),
              Neumorphic(
                style: BlossomNeumorphicStyles.eightConcave,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
                  child: NeumorphicText(
                    ParseUtils.checkIfNegative(
                        ParseUtils.formatAmount(
                            transaction.amount)),
                    textStyle: BlossomNeumorphicText.mediumBody,
                    style: BlossomNeumorphicStyles.fourGrey,
                  ),
                ),
              ),
            ],
          )
      )
    });
  }
}
