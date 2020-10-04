import 'package:flutter/material.dart';
import 'package:main/client/transactions_client.dart';
import 'package:main/components/drawer_container.dart';
import 'package:main/models/global/activeUser.dart';
import 'package:main/models/transactions/transactions_get_response.dart';
import 'package:main/theme/blossom_text.dart';
import 'package:main/widgets/nav_drawer.dart';
import 'package:scoped_model/scoped_model.dart';

class TransactionsScreen extends StatefulWidget {
  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final TransactionsClient _transactionsClient = TransactionsClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          NavDrawer(),
          DrawerContainer(
            children: [
              Text('Transactions', style: BlossomText.headline),
            ],
          ),
        ],
      ),
    );
  }

  Future<List<Widget>> _loadAccounts() async {
    final String phone =
        ScopedModel
            .of<ActiveUser>(context, rebuildOnChange: true)
            .phone;
    final TransactionsGetResponse _getResponse = _transactionsClient
        .getTransactionsForUser(phone, transactionQuery, dateStart, dateFinish)
    return await _buildAccountsByInstitution();
  }
}
