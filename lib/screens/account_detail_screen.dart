import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:main/components/drawer_container.dart';
import 'package:main/constants/accounts_page_constants.dart';
import 'package:main/constants/transaction_page_constants.dart';
import 'package:main/models/accounts/account.dart';
import 'package:main/theme/blossom_neumorphic_styles.dart';
import 'package:main/theme/blossom_neumorphic_text.dart';
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
                  NeumorphicText(_account.name,
                      textStyle: BlossomNeumorphicText.title,
                      style: BlossomNeumorphicStyles.fourGrey),
                  ParseUtils.parseAccountMask(_account.mask),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Card(
                    margin: EdgeInsets.all(20),
                    child: ListTile(
                        title: NeumorphicText(
                            AccountsPageConstants.AVAILABLE_BALANCE,
                            textStyle: BlossomNeumorphicText.body,
                            style: BlossomNeumorphicStyles.fourGrey),
                        subtitle: NeumorphicText(
                            ParseUtils.formatAmount(_account.balances.current),
                            textStyle: BlossomNeumorphicText.body,
                            style: BlossomNeumorphicStyles.fourGrey))),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Card(
                    margin: EdgeInsets.all(20),
                    child: ListTile(
                        title: NeumorphicText(
                            TransactionsPageConstants.TRANSACTIONS,
                            textStyle: BlossomNeumorphicText.body,
                            style: BlossomNeumorphicStyles.fourGrey)),
                  ))
            ],
          ),
        ])
      ]),
    );
  }
}
