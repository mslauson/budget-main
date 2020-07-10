import 'dart:convert';
import 'dart:ui';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jiffy/jiffy.dart';
import 'package:main/client/accountsClient.dart';
import 'package:main/client/budgetClient.dart';
import 'package:main/client/plaidMicroserviceClient.dart';
import 'package:main/client/transactionsClient.dart';
import 'package:main/components/plaidLinkWebView.dart';
import 'package:main/constants/plaidConstants.dart';
import 'package:main/constants/transactionsMicroserviceConstants.dart';
import 'package:main/constants/transactionsPageConstants.dart';
import 'package:main/models/accounts/AccessTokensResponse.dart';
import 'package:main/models/accounts/getAccountsResponse.dart';
import 'package:main/models/budget/getBudgetsResponse.dart';
import 'package:main/models/global/activeUser.dart';
import 'package:main/models/plaid/putTransactionsRequest.dart';
import 'package:main/models/transactions/transactionsGetResponse.dart';

class SecureHomeWidgets {
  static BuildContext context;
  static const TextStyle _optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static GetAccountsResponse accountsResponse;
  static TransactionsGetResponse transactionsGetResponse;
  static GetBudgetsResponse getBudgetResponse;
  static AccessTokensResponse accessTokenResponse;
  static List<Widget> accountWidgetList, budgetWidgetList;
  static List<DataRow> transactionsWidgetList = new List<DataRow>();
  static String monthStart =
      Jiffy().startOf(Units.MONTH).toIso8601String().split("T")[0];

  static List<Widget> widgetOptions(
      BuildContext context, ActiveUser activeUser) {
    return <Widget>[
      Text(
        'Index 0: Home',
        style: _optionStyle,
      ),
      Padding(
        padding: EdgeInsets.only(left: 2, right: 2),
        child: Scaffold(
          body: SingleChildScrollView(
            child: FutureBuilder(
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return new Column(children: budgetWidgetList);
              },
            ),
          ),
          floatingActionButton: new FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => {},
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Scaffold(
          body: SingleChildScrollView(
            child: FutureBuilder(
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 2,
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: 500,
                      child: DataTable(
                        columnSpacing: 1,
                        columns: [
                          DataColumn(
                              label: Text(TransactionsPageConstants.DATE)),
                          DataColumn(
                              label: Text(TransactionsPageConstants.MERCHANT)),
                          DataColumn(
                              label: Text(TransactionsPageConstants.ACCOUNT)),
                          DataColumn(
                              label: Text(TransactionsPageConstants.BUDGET)),
                          DataColumn(
                              label: Text(TransactionsPageConstants.AMOUNT)),
                        ],
                        rows: transactionsWidgetList,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          floatingActionButton: new FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => PlaidLinkWebView(
                        websiteName: PlaidConstants.PLAID_LINK_WIDGET_TITLE,
                        websiteUrl: PlaidConstants.PLAID_LINK_URL,
                      )))
            },
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Scaffold(
          body: SingleChildScrollView(
            child: FutureBuilder(
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 2,
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(8),
                    child: Column(
                      children: accountWidgetList,
                    ),
                  ),
                );
              },
            ),
          ),
          floatingActionButton: new FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => PlaidLinkWebView(
                        websiteName: PlaidConstants.PLAID_LINK_WIDGET_TITLE,
                        websiteUrl: PlaidConstants.PLAID_LINK_URL,
                      )))
            },
          ),
        ),
      ),
      Text(
        'Index 2: School',
        style: _optionStyle,
      ),
    ];
  }

  static Future<void> loadData(String email, String lastLogin) async {
    accessTokenResponse = await _loadAccessTokens(email);
    putAccessTokensToPlaidMicroservice(email, lastLogin)
        .whenComplete(() async => {
              accountsResponse = await _loadAccounts(email),
              transactionsGetResponse = await _loadTransactions(email),
              getBudgetResponse = await _loadBudgets(email),
              _buildAccountList(),
              _buildTransactionList(),
              _buildBudgetList()
            });
  }

  static _loadAccessTokens(String email) async {
    return await AccountsClient.getAccessTokensForUser(email);
  }

  static Future putAccessTokensToPlaidMicroservice(
      String email, String lastLogin) async {
    if (accessTokenResponse != null &&
        accessTokenResponse.accessTokens != null &&
        accessTokenResponse.accessTokens.isNotEmpty) {
      List<PutTransactionsRequest> requests =
          _buildPlaidTransactionsRequest(email, lastLogin);
      requests.forEach((request) {
        PlaidMicroserviceClient.addTransactions(jsonEncode(request));
      });
    }
  }

  static _loadAccounts(String email) async {
    return await AccountsClient.getAccountsForUser(email);
  }

  static _loadTransactions(String email) async {
    Jiffy jiffy = new Jiffy();
    DateTime nextMonthDt = jiffy.add(months: 1);
    Jiffy nextMonthJiffy = new Jiffy(nextMonthDt);
    String monthEnd =
        nextMonthJiffy.startOf(Units.MONTH).toIso8601String().split("T")[0];
    return await TransactionsClient.getTransactionsForUser(
        email,
        TransactionsMicroserviceConstants.DATE_TIME_RANGE_QUERY,
        monthStart,
        monthEnd);
  }

  static _loadBudgets(String email) async {
    return await BudgetClient.getBudgetsForUser(email, monthStart);
  }

  static void _buildAccountList() {
    List<Widget> widgets = new List<Widget>();
    List<Widget> accountWidgets;
    var bytes;

    if (accountsResponse != null && accountsResponse.itemList != null) {
      accountsResponse.itemList.forEach((item) => {
            accountWidgets = new List<Widget>(),
            item.accounts.forEach((account) => {
                  accountWidgets.add(Row(
                    children: <Widget>[
                      Text(account.name),
                      Text(account.mask),
                      Text(account.balances.current.toString())
                    ],
                  ))
                }),
            widgets.add(
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        child: ExpandablePanel(
                          theme: ExpandableThemeData(),
                          header: Row(
                            children: <Widget>[
                              Text(
                                item.institution.name,
                                style: TextStyle(fontSize: 15),
                              ),
                              Image.memory(
                                base64Decode(item.institution.logo),
                                height: 10,
                                width: 10,
                              )
                            ],
                          ),
                          expanded: Column(
                            children: accountWidgets,
                          ),
                          tapHeaderToExpand: true,
                          hasIcon: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          });
    } else {
      widgets.add(new Text("No Accounts"));
    }
    accountWidgetList = widgets;
  }

  static void _buildTransactionList() {
    String accountName = "";
    List<DataRow> widgets = new List<DataRow>();
    if (transactionsGetResponse != null &&
        transactionsGetResponse.transactions != null) {
      transactionsGetResponse.transactions.forEach((transaction) {
        accountsResponse.itemList.forEach((item) {
          item.accounts.forEach((account) {
            if (account.id == transaction.accountId) {
              accountName = account.name;
            }
          });
        });
        widgets.add(new DataRow(cells: [
          DataCell(new Text(transaction.date)),
          DataCell(new Text(transaction.merchant)),
          DataCell(new Text(accountName)),
          DataCell(new Text("")),
          DataCell(new Text(transaction.amount.toString())),
        ]));
      });
    } else {
      widgets.add(new DataRow(cells: [
        DataCell(new Text("No Transactions")),
        DataCell(new Text("")),
        DataCell(new Text("")),
        DataCell(new Text("")),
        DataCell(new Text("")),
      ]));
    }
    transactionsWidgetList = widgets;
  }

  static void _buildBudgetList() {
    List<Widget> widgets = new List();
    if (getBudgetResponse == null || getBudgetResponse.budgets == null || !getBudgetResponse.budgets.isNotEmpty) {
      widgets.add(new Card());
    } else {
      getBudgetResponse.budgets.forEach(
        (budget) {
          widgets.add(
            new Card(
              elevation: 10,
              child: InkWell(
                onLongPress: () {
                  Fluttertoast.showToast(msg: "tHE REAL DEAL");
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Row(
                        children: <Widget>[
                          Flexible(
                            child: ListTile(
                              contentPadding: EdgeInsets.all(1),
                              title: Text(budget.name),
                              subtitle: InkWell(
                                  onTap: () {
                                    Fluttertoast.showToast(
                                        msg: "HIIII",
                                        toastLength: Toast.LENGTH_LONG);
                                  },
                                  child: Text('Expand')),
                            ),
                          ),
                          Flexible(
                            child: ListTile(
                              title: Text(budget.used.toString()),
                              subtitle: Text(budget.allocation.toString()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
    budgetWidgetList = widgets;
  }

  static List<PutTransactionsRequest> _buildPlaidTransactionsRequest(
      String email, String lastLogin) {
    List<PutTransactionsRequest> requests = new List();
    String todayString = Jiffy().dateTime.toIso8601String().split("T")[0];
    if (accessTokenResponse != null) {
      accessTokenResponse.accessTokens.forEach((accessToken) {
        requests.add(new PutTransactionsRequest(
            accessToken: accessToken.accessToken,
            email: email,
            startDate: lastLogin,
            endDate: todayString));
      });
    }
    return requests;
  }
}
