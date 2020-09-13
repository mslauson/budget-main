import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:main/components/drawer_container.dart';
import 'package:main/constants/accounts_page_constants.dart';
import 'package:main/models/accounts/account.dart';
import 'package:main/theme/blossom_text.dart';
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
                  _parseAccountMask(_account.mask),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Card(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(AccountsPageConstants.AVAILABLE_BALANCE,
                          style: BlossomText.body),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      ),
                      _parseAvailableBalance(_account.balances.current)
                    ],
                  ),
                ),
              )
            ],
          ),
        ])
      ]),
    );
  }

  Text _parseAccountMask(String mask) {
    int length = mask.length;
    mask.replaceRange(0, length - 4, "X");
    return Text(mask, style: BlossomText.accountNumber);
  }

  Text _parseAvailableBalance(double balance) {
    var formatter = new NumberFormat("#,###.0#", "en_US");
    String formattedBalance = formatter.format(balance);
    return Text("\$" + formattedBalance, style: BlossomText.mediumBody);
  }
}
