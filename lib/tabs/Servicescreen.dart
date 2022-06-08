import 'package:flutter/material.dart';

import '../screenPanskill/HomePage.dart';
class ServicePage extends StatelessWidget {
  const ServicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color mainColor = Color(0xff014c92);

    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text("PANSKILL"),
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 16.0),

        backgroundColor: mainColor,
      ),
      body: Container(
        child: Center(
          child: Column(
            // center the children
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.adb,
                size: 160.0,
                color: Colors.white,
              ),
              Text(
                "Service tabs",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
      drawer: MyDrawerDirectory(),
    );
  }
}
