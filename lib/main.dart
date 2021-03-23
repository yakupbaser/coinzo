import 'package:challenge/app/app.locator.dart';
import 'package:flutter/material.dart';
import 'ui/views/home/home_view.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF1F2737),
        iconTheme: IconThemeData(color: Colors.black54),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black),
          bodyText2: TextStyle(color: Color(0xFFFFFFFF)),
        ),
        accentIconTheme: IconThemeData(color: Colors.white),
        scaffoldBackgroundColor: Color(0xFF19212C),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: HomeView(),
    );
  }
}
