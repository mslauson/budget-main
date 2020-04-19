import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:main/constants/secureHomeConstants.dart';
import 'package:main/ui/secureHome/secureHomeWidgets.dart';

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
      body: Container(
        child: 
            Center(child: SecureHomeWidgets.widgetOptions(context).elementAt(_selectedIndex))
        ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Dashboard'),
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


