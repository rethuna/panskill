import 'package:flutter/material.dart';
import 'package:panskill/screenPanskill/verify_otp.dart';
import 'screenPanskill/loginscreen.dart';

void main()  {
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
      ),
      home: LoginDemo(),
    );
  }
}
