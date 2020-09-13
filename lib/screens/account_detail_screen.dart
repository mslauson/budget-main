import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:main/components/drawer_container.dart';
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
                children: [
                  Text(
                    _account.name,
                    style: BlossomText.title,
                  ),
                  Text(_account.mask),
                  Image.memory(
                    base64Decode(_logo),
                    height: 60,
                    width: 60,
                  ),
                ],
              )
            ],
          ),
        ])
      ]),
    );
  }
}
