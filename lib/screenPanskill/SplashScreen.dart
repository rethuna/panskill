import 'dart:async';
import 'package:flutter/material.dart';

import 'Loginscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PANSKILL',
      theme: ThemeData(primaryColor: Color(0xff014c92)),
      home: SplashDemo(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashDemo extends StatefulWidget {
  @override
  SplashDemoState createState() => SplashDemoState();
}
class SplashDemoState extends State<SplashDemo> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginDemo())));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xff033B6F),
        child: Image(
          image: AssetImage('data_repo/images/panlogo.png'),
        ));
  }
}
