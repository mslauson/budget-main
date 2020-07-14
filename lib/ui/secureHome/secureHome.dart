import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:main/constants/secureHomeConstants.dart';
import 'package:main/models/global/activeUser.dart';
import 'package:main/ui/secureHome/secureHomeWidgets.dart';
import 'package:scoped_model/scoped_model.dart';

class SecureHome extends StatefulWidget {
  SecureHome({Key key}) : super(key: key);

  @override
  _SecureHomeState createState() => _SecureHomeState();
}

class _SecureHomeState extends State<SecureHome> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(SecureHomeConstants.SECURE_HOME_WELCOME),
        backgroundColor: Theme.of(context).accentColor,
        centerTitle: true,
      ),
      body: ScopedModelDescendant<ActiveUser>(
          builder: (BuildContext context, Widget child, ActiveUser model) {
            SecureHomeWidgets.loadData(model.email, model.lastLogin);
        return Container(
            child: Center(
                child: SecureHomeWidgets.widgetOptions(context, model)
                    .elementAt(_selectedIndex)));
      }),
      bottomNavigationBar: BottomNavigationBar(
        //TODO: get colors to work with the shifting nav bar
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Dashboard'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Budgets'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            title: Text('Transactions'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            title: Text('Accounts'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
