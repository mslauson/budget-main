import 'package:flutter/material.dart';
import 'package:main/model/global/activeUser.dart';
import 'package:main/ui/home/splash.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
        home: new Splash())
    );
  }
}
