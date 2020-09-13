import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:main/models/accounts/account.dart';
import 'package:main/theme/blossom_text.dart';

class AccountDetailScreen extends StatelessWidget {
  final Account _account;
  final String _logo;

  AccountDetailScreen(this._account, this._logo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
    );
  }
}
