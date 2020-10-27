import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:main/models/global/activeUser.dart';
import 'package:scoped_model/scoped_model.dart';

import 'constants/global_constants.dart';
import 'constants/routes.dart';
import 'screens/accounts_screen.dart';
import 'screens/budgets_screen.dart';
import 'screens/dash_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/splash.dart';
import 'screens/transactions_screen.dart';

void main() {
  _buildRouter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScopedModel<ActiveUser>(
      model: new ActiveUser(),
      child: MaterialApp(
        title: GlobalConstants.appName,
        home: Splash(),
        onGenerateRoute: (settings) => FluroRouter.appRouter
            .matchRoute(context, settings.name, routeSettings: settings)
            .route,
        theme: _buildThemeData(),
      ),
    );
  }
}

ThemeData _buildThemeData() => ThemeData(
      primarySwatch: Colors.lightBlue,
      scaffoldBackgroundColor: Colors.white,
      disabledColor: Colors.grey,
      buttonTheme: ButtonThemeData(buttonColor: Colors.lightBlue),
      bottomAppBarTheme: BottomAppBarTheme(color: Colors.lightBlue),
      textTheme: TextTheme(
        button: TextStyle(
          color: Colors.white,
        ),
      ),
    );

FluroRouter _buildRouter() =>
    FluroRouter.appRouter..define(
      Routes.home,
      transitionType: TransitionType.fadeIn,
      handler: Handler(
        handlerFunc: (context, params) => Splash(),
      ),
    )..define(
      Routes.formOtp,
      transitionType: TransitionType.fadeIn,
    handler: Handler(
      handlerFunc: (context, params) => Splash(),
    ),
  )
  ..define(
    Routes.formUserPhone,
    transitionType: TransitionType.fadeIn,
    handler: Handler(
      handlerFunc: (context, params) => Splash(),
    ),
  )
  ..define(
    Routes.formUserRegistration,
    transitionType: TransitionType.fadeIn,
    handler: Handler(
      handlerFunc: (context, params) => Splash(),
    ),
  )
  ..define(
    Routes.formUserProfile,
    transitionType: TransitionType.fadeIn,
    handler: Handler(
      handlerFunc: (context, params) => Splash(),
    ),
  )
  ..define(
    Routes.blossomDash,
    transitionType: TransitionType.fadeIn,
    handler: Handler(
      handlerFunc: (context, params) => DashScreen(),
    ),
  )
  ..define(
    Routes.blossomBudgets,
    transitionType: TransitionType.cupertino,
    handler: Handler(
      handlerFunc: (context, params) => BudgetsScreen(),
    ),
  )
  ..define(
    Routes.blossomBudgetById,
    transitionType: TransitionType.fadeIn,
    handler: Handler(
      handlerFunc: (context, params) => Splash(),
    ),
  )
  ..define(
    Routes.blossomAccounts,
    transitionType: TransitionType.cupertino,
    handler: Handler(
      handlerFunc: (context, params) => AccountsScreen(),
    ),
  )
  ..define(
    Routes.blossomAccountById,
    transitionType: TransitionType.fadeIn,
    handler: Handler(
      handlerFunc: (context, params) => Splash(),
    ),
  )
  ..define(
    Routes.blossomTransactions,
    transitionType: TransitionType.cupertino,
    handler: Handler(
      handlerFunc: (context, params) => TransactionsScreen(),
    ),
  )
  ..define(
    Routes.blossomTransactionById,
    transitionType: TransitionType.fadeIn,
    handler: Handler(
      handlerFunc: (context, params) => Splash(),
    ),
  )
  ..define(
    Routes.blossomProfile,
    transitionType: TransitionType.cupertino,
    handler: Handler(
      handlerFunc: (context, params) => ProfileScreen(),
    ),
  );
