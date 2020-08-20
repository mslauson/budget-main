import 'package:flutter/widgets.dart';

class DrawerItem {
  final String name;
  final String route;
  final IconData icon;

  DrawerItem({
    @required this.name,
    @required this.route,
    this.icon,
  });
}
