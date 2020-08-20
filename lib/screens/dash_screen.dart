import 'package:flutter/material.dart';
import 'package:main/components/drawer_container.dart';
import 'package:main/screens/drawer_screen.dart';
import 'package:main/theme/blossom_text.dart';

class DashScreen extends StatelessWidget {
  DashScreen({Key key}) : super(key: key);

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
