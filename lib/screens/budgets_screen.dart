import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:main/client/budget_client.dart';
import 'package:main/components/drawer_container.dart';
import 'package:main/models/budget/getBudgetsResponse.dart';
import 'package:main/models/global/activeUser.dart';
import 'package:main/theme/blossom_neumorphic_styles.dart';
import 'package:main/theme/blossom_neumorphic_text.dart';
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
    return await _buidBudgets(budgetResponse);
  }

  Future<List<Widget>> _buidBudgets(GetBudgetsResponse budgetResponse) async {
    List<Widget> _budgetWidgets = new List();
    _budgetWidgets.add(NeumorphicText('Budgets',
        textStyle: BlossomNeumorphicText.headline,
        style: BlossomNeumorphicStyles.eightGrey));
    _budgetWidgets.addAll(await _buildWidgetForBudgets(budgetResponse));
    return _budgetWidgets;
  }

  Future<List<Widget>> _buildWidgetForBudgets(
      GetBudgetsResponse budgetResponse) async {
    List<Widget> widgets = new List();
    budgetResponse.budgets.forEach((budget) {
      final Icon iconData =
          IconUtil.determineIcon(ParseUtils.parseBudgetId(budget.id));
      final Widget graph = _buildGraphForBudget(budget.allocation, budget.used);
      widgets.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Neumorphic(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              Neumorphic(
                child: Row(
                  children: [
                    Neumorphic(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: NeumorphicIcon(iconData.icon,
                              style: BlossomNeumorphicStyles.twentyIconGrey),
                        ),
                        style: BlossomNeumorphicStyles.fourIconCircle),
                    Column(
                      children: [
                        NeumorphicText(ParseUtils.parseBudgetId(budget.id),
                            textStyle: BlossomNeumorphicText.largeBodyBold,
                            style: BlossomNeumorphicStyles.fourGrey),
                        NeumorphicText(
                            "Left To Spend: " +
                                MathUtils.getAvailabileBalance(
                                    budget.allocation, budget.used),
                            textStyle: BlossomNeumorphicText.body,
                            style: BlossomNeumorphicStyles.fourGrey),
                      ],
                    ),
                    graph
                  ],
                ),
                style: BlossomNeumorphicStyles.negativeEightConcave,
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
    if (allocated == 0.00 || !used.isNegative) {
      percent = 1.00;
    }
    return Flexible(
      child: NeumorphicProgress(
          percent: percent,
          style: ProgressStyle(accent: Colors.red, variant: Colors.green)),
      flex: 1,
    );
  }
}
