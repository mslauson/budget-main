import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:main/models/global/activeUser.dart';
import 'package:main/screens/splash.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScopedModel<ActiveUser>(
        model: new ActiveUser(),
        child: MaterialApp(
            title: 'Blossom',
            theme: ThemeData(
                primarySwatch: Colors.lightBlue,
                scaffoldBackgroundColor: Colors.white,
                disabledColor: Colors.grey,
                buttonTheme: ButtonThemeData(buttonColor: Colors.lightBlue),
                bottomAppBarTheme: BottomAppBarTheme(color: Colors.lightBlue),
                textTheme: TextTheme(
                    button: TextStyle(
                      color: Colors.white,
                    ))),
            home: new Splash()));
  }
}
