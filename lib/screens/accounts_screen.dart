import 'dart:convert';
import 'dart:developer';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:main/client/accounts_client.dart';
import 'package:main/client/plaid_client.dart';
import 'package:main/client/transactions_client.dart';
import 'package:main/components/drawer_container.dart';
import 'package:main/constants/accounts_page_constants.dart';
import 'package:main/constants/plaid_constants.dart';
import 'package:main/models/accounts/account.dart';
import 'package:main/models/accounts/accounts_full_model.dart';
import 'package:main/models/accounts/accounts_sccoped_model.dart';
import 'package:main/models/accounts/delete_account_request_model.dart';
import 'package:main/models/accounts/response/accounts_response.dart';
import 'package:main/models/global/activeUser.dart';
import 'package:main/models/plaid/request/plaid_generic_request.dart';
import 'package:main/screens/account_detail_screen.dart';
import 'package:main/service/plaid/plaid_service.dart';
import 'package:main/theme/blossom_neumorphic_styles.dart';
import 'package:main/theme/blossom_neumorphic_text.dart';
import 'package:main/theme/blossom_spacing.dart';
import 'package:main/theme/blossom_text.dart';
import 'package:main/theme/budget_icons.dart';
import 'package:main/util/parse_utils.dart';
import 'package:main/widgets/nav_drawer.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AccountsScreen extends StatefulWidget {
  @override
  _AccountsScreenState createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  AccountsResponseModel accountsResponseModel;
  final AccountsClient _accountsClient = AccountsClient();
  final PlaidClient _plaidClient = PlaidClient();
  final TransactionsClient _transactionsClient = TransactionsClient();
  final PanelController _deletePanelController = PanelController();
  final PanelController _relinkPanelController = PanelController();
  String _phone;
  String _itemId;
  String _accessToken;

  @override
  Widget build(BuildContext context) {
    final String phone =
        ScopedModel.of<ActiveUser>(context, rebuildOnChange: true).phone;
    final PlaidService _plaidService =
        PlaidService(onfinish: () => Navigator.pop(context));
    //cancelPanel
    return SlidingUpPanel(
        minHeight: 0,
        maxHeight: 80,
        controller: _deletePanelController,
        panel: GestureDetector(
          onTap: () {
            _cancelItem();
            _deletePanelController.close();
          },
          child: Neumorphic(
            child: Row(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(left: 8)),
                Neumorphic(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: NeumorphicIcon(BudgetIcons.DELETE.icon,
                          style: BlossomNeumorphicStyles.twentyIconGrey),
                    ),
                    style: BlossomNeumorphicStyles.fourIconCircleWhite),
                Spacer(
                  flex: 1,
                ),
                NeumorphicText(AccountsPageConstants.REMOVE_INSTITUTION,
                    textStyle: BlossomNeumorphicText.body,
                    style: BlossomNeumorphicStyles.eightGrey),
                Spacer(
                  flex: 1,
                )
              ],
            ),
          ),
        ),
        //relink panel
        body: SlidingUpPanel(
          minHeight: 0,
          maxHeight: 80,
          controller: _relinkPanelController,
          panel: GestureDetector(
            onTap: () {
              _plaidService.openLinkFixAccount(phone, _accessToken, _itemId);
              _relinkPanelController.close();
            },
            child: Neumorphic(
              child: Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(left: 8)),
                  Neumorphic(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: NeumorphicIcon(BudgetIcons.TRANSFER.icon,
                            style: BlossomNeumorphicStyles.twentyIconGrey),
                      ),
                      style: BlossomNeumorphicStyles.fourIconCircleWhite),
                  Spacer(
                    flex: 1,
                  ),
                  NeumorphicText(AccountsPageConstants.RELINK_INSTITUTION,
                      textStyle: BlossomNeumorphicText.body,
                      style: BlossomNeumorphicStyles.eightGrey),
                  Spacer(
                    flex: 1,
                  )
                ],
              ),
            ),
          ),
          body: Scaffold(
            extendBody: true,
            floatingActionButton: FloatingActionButton(
              child: Icon(FontAwesomeIcons.plus),
              backgroundColor: Colors.white,
              onPressed: () => _plaidService.openLinkNewAccount(phone),
            ),
            body: Stack(
              children: [
                NavDrawer(),
                DrawerContainer(children: [
                  FutureBuilder(
                    future: _loadAccounts(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        //TODO: display toast
                        log(snapshot.error);
                      }
                      if (snapshot.hasData) {
                        return GestureDetector(
                            onTap: () {
                              if (_deletePanelController.isPanelOpen) {
                                _deletePanelController.close();
                              }
                              if (_relinkPanelController.isPanelOpen) {
                                _relinkPanelController.close();
                              }
                            },
                            child: Column(children: snapshot.data));
                      } else {
                        return Loading(indicator: BallPulseIndicator());
                      }
                    },
                  ),
                ]),
              ],
            ),
          ),
        ));
  }

  Future<List<Widget>> _loadAccounts() async {
    final String phone =
        ScopedModel.of<ActiveUser>(context, rebuildOnChange: true).phone;
    this.accountsResponseModel =
        ScopedModel.of<AccountsScopedModel>(context, rebuildOnChange: true)
            .responseModel;
    return await _buildAccountsByInstitution(phone);
  }

  List<Widget> _buildAccountsByType(
      AccountsResponseModel accountsResponseModel) {}

  Future<List<Widget>> _buildAccountsByInstitution(String phone) async {
    List<Widget> accountsWidgetList = new List();
    accountsWidgetList.add(Text('Accounts', style: BlossomText.headline));
    accountsResponseModel.itemList.forEach((accountsModel) async {
      List<Widget> accountsList = await _createAccountsList(
          accountsModel.accounts, accountsModel.institution.logo);
      Widget collapsed = _buildCollapsedWidgets(accountsModel, phone);
      accountsList.insert(0, collapsed);
      accountsWidgetList.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Neumorphic(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ExpandablePanel(
              collapsed: collapsed,
              expanded: Column(children: accountsList),
            ),
          ),
          style: BlossomNeumorphicStyles.standardBack,
        ),
      ));
    });
    return accountsWidgetList;
  }

  Future<List<Widget>> _createAccountsList(
      List<Account> accounts, String logo) async {
    List<Widget> _accountSubList = new List();
    List<Widget> _returnList = new List();
    _returnList.add(BlossomSpacing.STANDARD_FORM);
    //TODO: figure out better way then using null in terinary
    List<Account> _depositoryAccounts = accounts
        .map((account) => account.type == AccountsPageConstants.DEPOSITORY_TYPE
            ? account
            : null)
        .toList();
    List<Account> _creditAccounts = accounts
        .map((account) =>
            account.type == AccountsPageConstants.CREDIT_TYPE ? account : null)
        .toList();
    List<Account> _loanAccounts = accounts
        .map((account) =>
            account.type == AccountsPageConstants.LOAN_TYPE ? account : null)
        .toList();
    List<Account> _investmentAccounts = accounts
        .map((account) => account.type == AccountsPageConstants.INVESTMENT_TYPE
            ? account
            : null)
        .toList();

    _accountSubList.add(Text(
        AccountsPageConstants.DEPOSITORY_TYPE.toUpperCase(),
        style: BlossomText.body));
    _accountSubList.add(Divider());
    _accountSubList
        .addAll(await _buildAccountTypeList(_depositoryAccounts, logo));

    _accountSubList.add(Text(AccountsPageConstants.CREDIT_TYPE.toUpperCase(),
        style: BlossomText.body));
    _accountSubList.add(Divider());
    _accountSubList.addAll(await _buildAccountTypeList(_creditAccounts, logo));

    _accountSubList.add(Text(AccountsPageConstants.LOAN_TYPE.toUpperCase(),
        style: BlossomText.body));
    _accountSubList.add(Divider());
    _accountSubList.addAll(await _buildAccountTypeList(_loanAccounts, logo));

    _accountSubList.add(Text(
        AccountsPageConstants.INVESTMENT_TYPE.toUpperCase(),
        style: BlossomText.body));
    _accountSubList.add(Divider());
    _accountSubList
        .addAll(await _buildAccountTypeList(_investmentAccounts, logo));

    _returnList.add(
      Neumorphic(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 8)),
            ConstrainedBox(
                constraints: BoxConstraints(minHeight: 300, maxHeight: 300),
                child: SingleChildScrollView(
                  child: Column(
                    children: _accountSubList,
                  ),
                ))
          ],
        ),
        style: BlossomNeumorphicStyles.negativeEightConcaveWhite,
      ),
    );

    return _returnList;
  }

  Future<List<Widget>> _buildAccountTypeList(
      List<Account> accounts, String logo) async {
    List<Widget> _accountTypeList = new List();
    int i = 0;
    int size = accounts.where((element) => element != null).length;
    accounts.forEach((account) {
      if (account != null) {
        _accountTypeList.add(InkWell(
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => new AccountDetailScreen(account, logo)),
            )
          },
          child: Row(children: [
            Spacer(flex: 1),
            NeumorphicText(account.name,
                textStyle: BlossomNeumorphicText.body,
                style: BlossomNeumorphicStyles.fourGrey),
            Spacer(flex: 1),
            ParseUtils.parseAccountMask(account.mask),
            Spacer(flex: 1),
            Neumorphic(
              style: BlossomNeumorphicStyles.eightConcaveWhite,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
                child: NeumorphicText(
                  ParseUtils.checkIfNegative(
                      ParseUtils.formatAmount(account.balances.current)),
                  textStyle: BlossomNeumorphicText.body,
                  style: BlossomNeumorphicStyles.fourGrey,
                ),
              ),
            ),
            Spacer(flex: 1),
          ]),
        ));
        if (i < size - 1) {
          _accountTypeList.add(Divider());
          i++;
        }
      }
    });

    _accountTypeList.add(Padding(padding: EdgeInsets.only(bottom: 8)));

    return _accountTypeList;
  }

  void _cancelItem() {
    _plaidClient
        .removeItem(PlaidGenericRequest(
            clientId: PlaidConstants.CLIENT_ID_SANDBOX,
            secret: PlaidConstants.CLIENT_SECRET_SANDBOX,
            accessToken: _accessToken))
        .whenComplete(() async => {
              await _accountsClient.deleteAccount(
                  DeleteAccountRequestModel(phone: _phone, accountId: _itemId)),
              await _transactionsClient.deleteTransactions(_phone, _itemId)
            });
  }

  Widget _buildCollapsedWidgets(AccountsFullModel accountsModel, String phone) {
    if (!accountsModel.needsUpdating) {
      return GestureDetector(
        onLongPress: () {
          _phone = phone;
          _itemId = accountsModel.id;
          _accessToken = accountsModel.accessToken;
          _deletePanelController.open();
        },
        onTap: () {
          if (_deletePanelController.isPanelOpen) {
            _deletePanelController.close();
          } else if (_relinkPanelController.isPanelOpen) {
            _relinkPanelController.close();
          }
        },
        child: Neumorphic(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpandableButton(
                child: Row(
                  children: [
                    Neumorphic(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Image.memory(
                            base64Decode(accountsModel.institution.logo),
                            height: 40,
                            width: 40,
                          ),
                        ),
                        style: BlossomNeumorphicStyles.fourIconCircleWhite),
                    Spacer(flex: 1),
                    NeumorphicText(accountsModel.institution.name,
                        textStyle: BlossomNeumorphicText.largeBodyBold,
                        style: BlossomNeumorphicStyles.fourGrey),
                    Spacer(flex: 1)
                  ],
                ),
              ),
            ),
            style: BlossomNeumorphicStyles.negativeEightConcaveWhite),
      );
    } else {
      return GestureDetector(
        onLongPress: () {
          _phone = phone;
          _itemId = accountsModel.id;
          _accessToken = accountsModel.accessToken;
          _deletePanelController.open();
        },
        onTap: () {
          _accessToken = accountsModel.accessToken;
          _itemId = accountsModel.id;
          if (_deletePanelController.isPanelOpen) {
            _deletePanelController.close();
          } else if (_relinkPanelController.isPanelOpen) {
            _relinkPanelController.close();
          } else {
            _relinkPanelController.open();
          }
        },
        child: Neumorphic(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Neumorphic(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: NeumorphicIcon(BudgetIcons.ATTENTION.icon,
                            style: BlossomNeumorphicStyles.twentyIconGrey),
                      ),
                      style: BlossomNeumorphicStyles.fourIconCircleWhite),
                  Spacer(flex: 1),
                  NeumorphicText(
                      accountsModel.institution.name +
                          AccountsPageConstants.NEEDS_ATTENTION,
                      textStyle: BlossomNeumorphicText.body,
                      style: BlossomNeumorphicStyles.fourGrey),
                  Spacer(flex: 1)
                ],
              ),
            ),
            style: BlossomNeumorphicStyles.negativeEightConcaveWhite),
      );
    }
  }
}
