import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:main/client/accountsClient.dart';
import 'package:main/components/plaidLinkWebView.dart';
import 'package:main/constants/plaidConstants.dart';
import 'package:main/constants/secureHomeConstants.dart';
import 'package:main/model/accounts/getAccountsResponse.dart';
import 'package:main/model/global/activeUser.dart';

class SecureHomeWidgets {
  static BuildContext context;
  static const TextStyle _optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static GetAccountsResponse getResponse;
  static List<Widget> accountWidgetList;

  static List<Widget> widgetOptions(
      BuildContext context, ActiveUser activeUser) {
    return <Widget>[
      Text(
        'Index 0: Home',
        style: _optionStyle,
      ),
      Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Scaffold(
          body: SingleChildScrollView(
            child: FutureBuilder(
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Column(
                  children: accountWidgetList,
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

  static Future<void> loadData(String email) async {
    getResponse = await _loadAccounts(email);
    _buildAccountList();
  }

  static _loadAccounts(String email) async {
    return await AccountsClient.getAccountsForUser(email);
  }

  static void _buildAccountList() {
    List<Widget> widgets = new List<Widget>();
    List<Widget> accountWidgets;

    getResponse.itemList.forEach((item) => {
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
                  children: <Widget>[
                    Text(item.institution.name),
                    Container(
                      child: Column(
                        children: accountWidgets,
                      ),
                    )
                  ],
                ))),
          )
        });
    accountWidgetList = widgets;
  }
}
