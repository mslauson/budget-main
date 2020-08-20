import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:main/components/drawer_container.dart';
import 'package:main/theme/blossom_text.dart';

import 'drawer_screen.dart';

class BudgetsScreen extends StatefulWidget {
  @override
  _BudgetsScreenState createState() => _BudgetsScreenState();
}

class _BudgetsScreenState extends State<BudgetsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          DrawerContainer(
            children: [
              Text('Budgets', style: BlossomText.headline),
            ],
          ),
        ],
      ),
    );
  }
}
