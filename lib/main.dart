import 'package:flutter/material.dart';
import 'package:panskill/screenPanskill/Business_post.dart';
import 'package:panskill/screenPanskill/Dashboard.dart';
import 'package:panskill/screenPanskill/TestPage.dart';
import 'screenPanskill/Loginscreen.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Panskill',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'CharisSIL',
        brightness: Brightness.light,
        /* light theme settings */
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'CharisSIL',
        brightness: Brightness.dark,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.light,
      home: LoginDemo()
    );
  }
}

