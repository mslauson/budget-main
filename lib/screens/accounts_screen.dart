import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:main/components/drawer_container.dart';
import 'package:main/theme/blossom_text.dart';

import 'drawer_screen.dart';

class AccountsScreen extends StatefulWidget {
  @override
  _AccountsScreenState createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          DrawerContainer(
            children: [
              Text('Accounts', style: BlossomText.headline),
            ],
          ),
        ],
      ),
    );
  }
}
