import 'package:flutter/material.dart';
import 'package:main/components/drawer_container.dart';
import 'package:main/theme/blossom_text.dart';
import 'package:main/widgets/nav_drawer.dart';

class DashScreen extends StatelessWidget {
  DashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          NavDrawer(),
          DrawerContainer(
            children: [
              Text('My Dashboard', style: BlossomText.headline),
            ],
          ),
        ],
      ),
    );
  }
}
