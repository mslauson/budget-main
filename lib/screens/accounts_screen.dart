import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:main/client/accounts_client.dart';
import 'package:main/components/drawer_container.dart';
import 'package:main/constants/accounts_page_constants.dart';
import 'package:main/models/accounts/account.dart';
import 'package:main/models/accounts/response/accounts_response.dart';
import 'package:main/models/global/activeUser.dart';
import 'package:main/screens/account_detail_screen.dart';
import 'package:main/theme/blossom_text.dart';
import 'package:main/widgets/nav_drawer.dart';
import 'package:scoped_model/scoped_model.dart';

class AccountsScreen extends StatefulWidget {
  @override
  _AccountsScreenState createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  AccountsResponseModel accountsResponseModel;
  final AccountsClient _accountsClient = AccountsClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          NavDrawer(),
          DrawerContainer(children: [
            FutureBuilder(
              future: _loadAccounts(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Column(children: snapshot.data);
                } else {
                  return Loading(indicator: BallPulseIndicator());
                }
              },
            ),
          ]),
        ],
      ),
    );
  }

  Future<List<Widget>> _loadAccounts() async {
    final String phone =
        ScopedModel.of<ActiveUser>(context, rebuildOnChange: true).phone;
    this.accountsResponseModel =
        await _accountsClient.getAccountsForUser(phone);
    return await _buildAccountsByInstitution();
  }

  List<Widget> _buildAccountsByType(
      AccountsResponseModel accountsResponseModel) {}

  Future<List<Widget>> _buildAccountsByInstitution() async {
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
              title: Text(AccountsPageConstants.ACCOUNTS,
                  style: BlossomText.mediumBody),
              children: await _createAccountsList(
                  accountsModel.accounts, accountsModel.institution.logo),
            ),
          ],
        )),
      );
    });
    return accountsWidgetList;
  }

  Future<List<Widget>> _createAccountsList(
      List<Account> accounts, String logo) async {
    List<Widget> _accountSubList = new List();
    //TODO: figure out better way then using null in terinary
    List<Account> _depositoryAccounts = accounts
        .map((account) => account.type == AccountsPageConstants.DEPOSITORY_TYPE
            ? account
            : null)
        .toList();
    List<Account> _creditAccounts = accounts
        .map((account) =>
            account.type == AccountsPageConstants.CREDIT_TYPE ? account : null)
        .toList();
    List<Account> _loanAccounts = accounts
        .map((account) =>
    account.type == AccountsPageConstants.LOAN_TYPE ? account : null)
        .toList();
    List<Account> _investmentAccounts = accounts
        .map((account) =>
    account.type == AccountsPageConstants.INVESTMENT_TYPE
        ? account
        : null)
        .toList();

    _accountSubList.add(Text(
        AccountsPageConstants.DEPOSITORY_TYPE.toUpperCase(),
        style: BlossomText.body));
    _accountSubList
        .addAll(await _buildAccountTypeList(_depositoryAccounts, logo));

    _accountSubList.add(Text(AccountsPageConstants.CREDIT_TYPE.toUpperCase(),
        style: BlossomText.body));
    _accountSubList.addAll(await _buildAccountTypeList(_creditAccounts, logo));

    _accountSubList.add(Text(AccountsPageConstants.LOAN_TYPE.toUpperCase(),
        style: BlossomText.body));
    _accountSubList.addAll(await _buildAccountTypeList(_loanAccounts, logo));

    _accountSubList.add(Text(
        AccountsPageConstants.INVESTMENT_TYPE.toUpperCase(),
        style: BlossomText.body));
    _accountSubList
        .addAll(await _buildAccountTypeList(_investmentAccounts, logo));

    return _accountSubList;
  }

  Future<List<Widget>> _buildAccountTypeList(List<Account> accounts,
      String logo) async {
    List<Widget> _accountTypeList = new List();
    accounts.forEach((account) {
      if (account != null) {
        _accountTypeList.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: InkWell(
                onTap: () =>
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        new AccountDetailScreen(account, logo)),
                  )
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(account.name, style: BlossomText.mediumBody),
                      Text("\$" + account.balances.current.toString(),
                          style: BlossomText.secondaryBody),
                      //TODO: Make look like checking number on check
                      Text(account.mask, style: BlossomText.secondaryBody),
                    ]),
              ),
            ),
          ),
        ));
      }
    });

    return _accountTypeList;
  }
}
