import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:main/components/drawer_container.dart';
import 'package:main/constants/accounts_page_constants.dart';
import 'package:main/models/accounts/accounts.dart';
import 'package:main/models/accounts/response/accounts_response.dart';
import 'package:main/models/global/activeUser.dart';
import 'package:main/service/secure/home_initialization_service.dart';
import 'package:main/theme/blossom_text.dart';
import 'package:main/widgets/nav_drawer.dart';
import 'package:scoped_model/scoped_model.dart';

class AccountsScreen extends StatefulWidget {
  @override
  _AccountsScreenState createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  AccountsResponseModel accountsResponseModel;
  List<Widget> _accountsWidgets;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          NavDrawer(),
          DrawerContainer(children: [
            SingleChildScrollView(
              child: FutureBuilder(
                future: _loadAccounts(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return new Column(children: _accountsWidgets);
                  } else {
                    //TODO:  Implement loading indicator
                    return Text("loading");
                  }
                },
              ),
            ),
          ]),
        ],
      ),
    );
  }

  Future<void> _loadAccounts() async {
    final String phone =
        ScopedModel.of<ActiveUser>(context, rebuildOnChange: true).phone;
    final HomeInitializationService initializationService =
        HomeInitializationService(getAccounts: _onLoaded);
    await initializationService.loadData(phone, context);
  }

  _onLoaded(AccountsResponseModel fullModel) async {
    this.accountsResponseModel = fullModel;
    await _buildAccountsByInstitution();
  }

  List<Widget> _buildAccountsByType(
      AccountsResponseModel accountsResponseModel) {}

  Future<void> _buildAccountsByInstitution() async {
    List<Widget> accountsWidgetList = new List();
    accountsWidgetList.add(Text('Accounts', style: BlossomText.headline));
    accountsResponseModel.itemList.forEach((accountsModel) async {
      accountsWidgetList.add(
        Card(
            child: Column(
          children: [
            ListTile(
              leading: Image.memory(
                base64Decode(accountsModel.institution.logo),
                height: 60,
                width: 60,
              ),
              title: Text(accountsModel.institution.name,
                  style: BlossomText.largeBody),
            ),
            ExpansionTile(
              title: Text(AccountsPageConstants.ACCOUNTS),
              children: await _createAccountsList(accountsModel.accounts),
            ),
          ],
        )),
      );
    });
    _accountsWidgets = accountsWidgetList;
  }

  Future<List<Widget>> _createAccountsList(List<Accounts> accounts) async {
    List<Widget> _accountSubList = new List();
    List<Accounts> _depositoryAccounts = accounts
        .map((account) =>
    account.type == AccountsPageConstants.DEPOSITORY_TYPE
        ? account
        : null)
        .toList();
    List<Accounts> _creditAccounts = accounts
        .map((account) =>
    account.type == AccountsPageConstants.CREDIT_TYPE ? account : null)
        .toList();
    List<Accounts> _loanAccounts = accounts
        .map((account) =>
    account.type == AccountsPageConstants.LOAN_TYPE ? account : null)
        .toList();
    List<Accounts> _investmentAccounts = accounts
        .map((account) =>
    account.type == AccountsPageConstants.INVESTMENT_TYPE
        ? account
        : null)
        .toList();

    _accountSubList.add(Text(AccountsPageConstants.DEPOSITORY_TYPE));
    _accountSubList.addAll(await _buildAccountTypeList(_depositoryAccounts));

    _accountSubList.add(Text(AccountsPageConstants.CREDIT_TYPE));
    _accountSubList.addAll(await _buildAccountTypeList(_creditAccounts));

    _accountSubList.add(Text(AccountsPageConstants.LOAN_TYPE));
    _accountSubList.addAll(await _buildAccountTypeList(_loanAccounts));

    _accountSubList.add(Text(AccountsPageConstants.INVESTMENT_TYPE));
    _accountSubList.addAll(await _buildAccountTypeList(_investmentAccounts));

    return _accountSubList;
  }

  Future<List<Widget>> _buildAccountTypeList(List<Accounts> accounts) async {
    List<Widget> _accountTypeList = new List();
    accounts.forEach((account) {
      _accountTypeList.add(Card(
        child: Row(
          children: [
            Text(account.name),
            Padding(padding: EdgeInsets.all(10)),
            Text("\$" + account.balances.current),
            Padding(padding: EdgeInsets.all(10)),
            Text("\$" + account.mask),
          ],
        ),
      ));
    });
    return _accountTypeList;
  }
}
