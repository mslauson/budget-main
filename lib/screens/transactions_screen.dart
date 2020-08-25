import 'package:flutter/material.dart';
import 'package:main/components/drawer_container.dart';
import 'package:main/theme/blossom_text.dart';

import 'drawer_screen.dart';

class TransactionsScreen extends StatefulWidget {
  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          DrawerContainer(
            children: [
              Text('Transactions', style: BlossomText.headline),
            ],
          ),
        ],
      ),
    );
  }
}
