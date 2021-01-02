import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:main/components/drawer_container.dart';
import 'package:main/constants/accounts_page_constants.dart';
import 'package:main/constants/transaction_page_constants.dart';
import 'package:main/models/accounts/account.dart';
import 'package:main/theme/blossom_text.dart';
import 'package:main/util/parse_utils.dart';
import 'package:main/widgets/nav_drawer.dart';

class AccountDetailScreen extends StatelessWidget {
  final Account _account;
  final String _logo;

  AccountDetailScreen(this._account, this._logo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        NavDrawer(),
        DrawerContainer(children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.memory(
                    base64Decode(_logo),
                    height: 60,
                    width: 60,
                  ),
                  Text(
                    _account.name,
                    style: BlossomText.title,
                  ),
                  ParseUtils.parseAccountMask(_account.mask),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Card(
                    margin: EdgeInsets.all(20),
                    child: ListTile(
                        title: Text(AccountsPageConstants.AVAILABLE_BALANCE,
                            style: BlossomText.body),
                        subtitle: Text(
                          ParseUtils.formatAmount(_account.balances.current),
                          style: BlossomText.mediumBody,
                        ))),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Card(
                    margin: EdgeInsets.all(20),
                    child: ListTile(
                        title: Text(TransactionsPageConstants.TRANSACTIONS,
                            style: BlossomText.body)),
                  ))
            ],
          ),
        ])
      ]),
    );
  }
}
