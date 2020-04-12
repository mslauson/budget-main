import 'package:flutter/material.dart';
import 'package:main/ui/home/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        scaffoldBackgroundColor: Colors.white,
        disabledColor: Colors.grey,
        textTheme: TextTheme(
          button: TextStyle(
            color: Colors.white,
          )
        )
      ),
      home:  new Splash()
    );
  }
}


