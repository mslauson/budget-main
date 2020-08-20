import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main/components/drawer_item.dart';
import 'package:main/constants/routes.dart';
import 'package:main/theme/blossom_text.dart';

class DrawerScreen extends StatefulWidget {
  DrawerScreen({Key key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      padding: EdgeInsets.only(top: 80, bottom: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildClientInfoRow(),
          Spacer(flex: 3),
          _buildLargeNavColumn(),
          Spacer(flex: 5),
          _buildSmallNavColumn(),
          Spacer(flex: 5),
          _buildSettingsLogoutRow(),
        ],
      ),
    );
  }

  Widget _buildClientInfoRow() => Row(
        children: [
          Spacer(flex: 1),
          CircleAvatar(backgroundColor: Colors.white),
          Spacer(flex: 1),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('John Doe', style: BlossomText.headlineLight),
              Text('Pro Member', style: BlossomText.bodyLight)
            ],
          ),
          Spacer(flex: 9),
        ],
      );

  Widget _buildLargeNavColumn() => Column(
    children: _buildLargeDrawerItems()
        .map((item) =>
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: GestureDetector(
            onTap: () =>
                Router.appRouter.navigateTo(context, item.route),
            child: Row(
              children: [
                Spacer(flex: 1),
                FaIcon(item.icon, color: Colors.white),
                SizedBox(width: 20),
                Text(item.name, style: BlossomText.titleLight),
                Spacer(flex: 12),
              ],
            ),
          ),
        ))
        .toList(),
  );

  Widget _buildSmallNavColumn() =>
      Column(
        children: _buildSmallDrawerItems()
            .map((item) =>
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Spacer(flex: 1),
                  Text(item.name, style: BlossomText.largeBodyLight),
                  Spacer(flex: 18),
                ],
              ),
            ))
            .toList(),
      );

  Widget _buildSettingsLogoutRow() =>
      Row(
        children: [
          Spacer(flex: 1),
          FaIcon(FontAwesomeIcons.cog, color: Colors.white),
          Spacer(flex: 1),
          Text('Settings', style: BlossomText.largeBodyLight),
          Spacer(flex: 1),
          Container(width: 2, height: 20, color: Colors.white),
          Spacer(flex: 1),
          Text('Log out', style: BlossomText.largeBodyLight),
          Spacer(flex: 10),
        ],
      );
}

List<DrawerItem> _buildLargeDrawerItems() =>
    [
      DrawerItem(
        name: 'Home',
        route: Routes.blossomDash,
        icon: FontAwesomeIcons.home,
      ),
      DrawerItem(
        name: 'Profile',
        route: Routes.blossomProfile,
        icon: FontAwesomeIcons.userAlt,
      ),
      DrawerItem(
        name: 'Budgets',
        route: Routes.blossomBudgets,
        icon: FontAwesomeIcons.handHoldingUsd,
      ),
      DrawerItem(
        name: 'Accounts',
        route: Routes.blossomAccounts,
        icon: FontAwesomeIcons.university,
      ),
      DrawerItem(
        name: 'Transactions',
        route: Routes.blossomTransactions,
        icon: FontAwesomeIcons.exchangeAlt,
      ),
    ];

List<DrawerItem> _buildSmallDrawerItems() =>
    [
      DrawerItem(
        name: 'About',
        route: Routes.blossomDash,
      ),
      DrawerItem(
        name: 'Social',
        route: Routes.blossomDash,
      ),
      DrawerItem(
        name: 'Terms',
        route: Routes.blossomDash,
      ),
      DrawerItem(
        name: 'FAQ',
        route: Routes.blossomDash,
      ),
    ];
