import 'package:flutter/material.dart';
import 'package:main/screens/dash_screen.dart';
import 'package:main/screens/drawer_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [DrawerScreen(), DashScreen()],
      ),
    );
  }
}
