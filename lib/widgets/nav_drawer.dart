import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main/components/drawer_item.dart';
import 'package:main/constants/routes.dart';
import 'package:main/theme/blossom_text.dart';

class NavDrawer extends StatefulWidget {
  NavDrawer({Key key}) : super(key: key);

  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
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
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 80, bottom: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Spacer(flex: 2),
            _buildClientInfoRow(),
            Spacer(flex: 1),
            _buildLargeNavColumn(),
            Spacer(flex: 5),
            _buildSettingsLogoutRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildClientInfoRow() => Row(
        children: [
          Spacer(flex: 2),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: CircleAvatar(
                  backgroundColor: Colors.black87,
                  radius: 50,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text('John Doe', style: BlossomText.headline)],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text('Pro Member', style: BlossomText.body)],
              ),
            ],
          ),
          Spacer(flex: 10),
        ],
      );

  Widget _buildLargeNavColumn() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildLargeDrawerItems()
            .map((item) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: GestureDetector(
                    onTap: () =>
                        Router.appRouter.navigateTo(context, item.route),
                    child: Row(
                      children: [
                        Spacer(flex: 2),
                        FaIcon(item.icon, color: Colors.black87),
                        SizedBox(width: 15),
                        Text(item.name, style: BlossomText.largeBody),
                        Spacer(flex: 10),
                      ],
                    ),
                  ),
                ))
            .toList(),
      );

  Widget _buildSettingsLogoutRow() => Row(
        children: [
          Spacer(flex: 2),
          FaIcon(FontAwesomeIcons.arrowCircleRight, color: Colors.black87),
          SizedBox(width: 15),
          Text('Log out', style: BlossomText.largeBody),
          Spacer(flex: 10),
        ],
      );
}

List<DrawerItem> _buildLargeDrawerItems() => [
      DrawerItem(
        name: 'Dashboard',
        route: Routes.blossomDash,
        icon: FontAwesomeIcons.chartPie,
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
