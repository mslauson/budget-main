import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:main/components/drawer_container.dart';
import 'package:main/constants/accounts_page_constants.dart';
import 'package:main/constants/transaction_page_constants.dart';
import 'package:main/models/accounts/account.dart';
import 'package:main/models/transactions/transactions.dart';
import 'package:main/theme/blossom_text.dart';
import 'package:main/util/parse_utils.dart';
import 'package:main/widgets/nav_drawer.dart';

class AccountDetailScreen extends StatelessWidget {
  final Transactions _transaction;
  final Icon _icon;

  AccountDetailScreen(this._transaction, this._icon);

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
                  NeumorphicIcon(_icon.icon),
                  Text(
                    _transaction.merchant,
                    style: BlossomText.title,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Card(
                    margin: EdgeInsets.all(20),
                    child: ListTile(
                        title: Text(AccountsPageConstants.AVAILABLE_BALANCE,
                            style: BlossomText.body),
                        subtitle: ParseUtils.parseAvailableBalance(
                            _account.balances.current))),
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
