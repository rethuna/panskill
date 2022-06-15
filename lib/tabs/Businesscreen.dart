import 'package:flutter/material.dart';

import '../screenPanskill/HomePage.dart';
import 'gridview.dart';
class BusinessPage extends StatelessWidget {
  const BusinessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color mainColor = Color(0xff014c92);
    MyGridView myGridView=new MyGridView();
    return Scaffold(
      appBar: AppBar(
        title: Text("PANSKILL"),
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 16.0),

        backgroundColor: mainColor,
      ),
      body: myGridView.build(),
      drawer: MyDrawerDirectory(),
    );
  }
}
