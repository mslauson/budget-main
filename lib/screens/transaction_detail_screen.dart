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
        child: Column(
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
      ),
    );
  }
}
