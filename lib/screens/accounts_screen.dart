import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:main/components/drawer_container.dart';
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
    accountsResponseModel.itemList.forEach((accountsModel) {
      accountsWidgetList.add(
        Card(
            child: Column(
              children: [
                ListTile(
                  leading: Image.memory(
                    base64Decode(accountsModel.institution.logo),
                    height: 10,
                    width: 10,
                  ),
                  title: Text(accountsModel.institution.name,
                      style: BlossomText.title),
                )
              ],
            )),
      );
    });
    _accountsWidgets = accountsWidgetList;
  }
}
