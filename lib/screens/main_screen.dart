import 'package:flutter/material.dart';
import 'package:main/screens/drawer_screen.dart';
import 'package:main/theme/blossom_text.dart';

import 'file:///C:/Users/verle/AndroidStudioProjects/budget-main/lib/components/drawer_container.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          DrawerContainer(
            children: [
              Text('Dashboard', style: BlossomText.headline),
            ],
          ),
        ],
      ),
    );
  }
}
