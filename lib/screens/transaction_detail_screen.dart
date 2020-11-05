import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:main/models/transactions/transactions.dart';
import 'package:main/theme/blossom_neumorphic_styles.dart';
import 'package:main/theme/blossom_neumorphic_text.dart';

class AccountDetailScreen extends StatelessWidget {
  final Transactions _transaction;
  final Icon _icon;

  AccountDetailScreen(this._transaction, this._icon);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NeumorphicIcon(_icon.icon),
              NeumorphicText(_transaction.merchant,
                  textStyle: BlossomNeumorphicText.title,
                  style: BlossomNeumorphicStyles.four)
            ],
              ),
            ],
          ),
    );
  }
}
