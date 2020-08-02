import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:main/constants/global_constants.dart';
import 'package:main/models/global/activeUser.dart';
import 'package:main/screens/accounts_screen.dart';
import 'package:main/screens/budgets_screen.dart';
import 'package:main/screens/dash_screen.dart';
import 'package:main/screens/profile_screen.dart';
import 'package:main/screens/splash.dart';
import 'package:main/screens/transactions_screen.dart';
import 'package:scoped_model/scoped_model.dart';

import 'constants/routes.dart';

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
        onGenerateRoute: (settings) => Router.appRouter
            .matchRoute(context, settings.name, routeSettings: settings)
            .route,
        theme: ThemeData(
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
        ),
      ),
    );
  }
}

Router _buildRouter() => Router.appRouter
  ..define(
    Routes.home,
    transitionType: TransitionType.fadeIn,
    handler: Handler(
      handlerFunc: (context, params) => Splash(),
    ),
  )
  ..define(
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
    transitionType: TransitionType.fadeIn,
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
    transitionType: TransitionType.fadeIn,
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
    transitionType: TransitionType.fadeIn,
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
    transitionType: TransitionType.fadeIn,
    handler: Handler(
      handlerFunc: (context, params) => ProfileScreen(),
    ),
  );
