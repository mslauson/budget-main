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

  @override
  Widget build(BuildContext context) {
    _loadAccounts();
    return Scaffold(
      body: Stack(
        children: [
          NavDrawer(),
          DrawerContainer(
            children: [
              Text('Accounts', style: BlossomText.headline),
            ],
          ),
        ],
      ),
    );
  }

  _loadAccounts() {
    final String phone =
        ScopedModel.of<ActiveUser>(context, rebuildOnChange: true).phone;
    final HomeInitializationService initializationService =
        HomeInitializationService(
            getAccounts: (AccountsResponseModel fullModel) {
      this.accountsResponseModel = fullModel;
    });
    initializationService.loadData(phone, context);
  }

  List<Widget> _buildAccountsByType(
      AccountsResponseModel accountsResponseModel) {}

  List<Widget> _buildAccountsByInstitution() {
    List<Widget> accountsWidgets = new List();
    accountsResponseModel.itemList.forEach((accountsModel) {
      accountsWidgets.add(
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
    return accountsWidgets;
  }
}
