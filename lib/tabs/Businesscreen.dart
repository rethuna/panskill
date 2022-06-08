import 'package:flutter/material.dart';

import '../screenPanskill/HomePage.dart';
class BusinessPage extends StatelessWidget {
  const BusinessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color mainColor = Color(0xff014c92);

    return Scaffold(
      appBar: AppBar(
        title: Text("PANSKILL"),
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 16.0),

        backgroundColor: mainColor,
      ),
      backgroundColor: Colors.green,
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
                "Business tabs",
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
