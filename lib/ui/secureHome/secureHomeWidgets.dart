import 'dart:convert';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:main/client/accountsClient.dart';
import 'package:main/components/plaidLinkWebView.dart';
import 'package:main/constants/accountsPageConstants.dart';
import 'package:main/constants/plaidConstants.dart';
import 'package:main/constants/secureHomeConstants.dart';
import 'package:main/model/accounts/getAccountsResponse.dart';
import 'package:main/model/global/activeUser.dart';
import 'dart:io' as Io;

class SecureHomeWidgets {
  static BuildContext context;
  static const TextStyle _optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static GetAccountsResponse accountsResponse;
  static 
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

  static Future<void> loadData(String email) async {
    accountsResponse = await _loadAccounts(email);

    _buildAccountList();
  }

  static _loadAccounts(String email) async {
    return await AccountsClient.getAccountsForUser(email);
  }

  static void _buildAccountList() {
    List<Widget> widgets = new List<Widget>();
    List<Widget> accountWidgets;
    var bytes;

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
                            Text(item.institution.name, style: TextStyle(fontSize:15 ),),
                            Image.memory(base64Decode(item.institution.logo), height: 10, width: 10,)
                          ],
                        ) ,
//                        collapsed: Text(
//                          article.body,
//                          softWrap: true,
//                          maxLines: 2,
//                          overflow: TextOverflow.ellipsis,
//                        ),
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
    accountWidgetList = widgets;
  }
}
