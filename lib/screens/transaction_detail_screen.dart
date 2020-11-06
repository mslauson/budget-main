import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:main/models/transactions/transactions_get_response.dart';
import 'package:main/theme/blossom_neumorphic_styles.dart';
import 'package:main/theme/blossom_neumorphic_text.dart';

class TransactionDetailScreen extends StatelessWidget {
  final Transactions _transaction;
  final Icon _icon;

  TransactionDetailScreen(this._transaction, this._icon);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Neumorphic(
        child: Padding(
          padding: EdgeInsets.only(top: 80, bottom: 50),
          child: Column(
            children: [
              ListTile(
                  leading: Neumorphic(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: NeumorphicIcon(_icon.icon,
                            style: BlossomNeumorphicStyles.twentyIconGrey),
                      ),
                      style: BlossomNeumorphicStyles.fourIconCircle),
                  title: NeumorphicText(_transaction.merchant,
                      textStyle: BlossomNeumorphicText.headline,
                      style: BlossomNeumorphicStyles.eightGrey)),
            ],
          ),
        ),
      ),
    );
  }
}
