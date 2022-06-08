import 'package:flutter/material.dart';

import '../screenPanskill/HomePage.dart';

class Home_tab extends StatefulWidget {
  const Home_tab({Key? key}) : super(key: key);

  @override
  State<Home_tab> createState() => _Home_tabState();
}

class _Home_tabState extends State<Home_tab> {
  List<String> images = [
    "asset/images/cleaning.png",
    "asset/images/elec.png",
    "asset/images/edu.png",
    "asset/images/floor.png",
    "asset/images/fabrication.png",
    "asset/images/dc.png",
    "asset/images/design.png",
    "asset/images/cleaning.png",
    "asset/images/elec.png",
    "asset/images/edu.png",
    "asset/images/floor.png",
    "asset/images/fabrication.png",
    "asset/images/dc.png",
    "asset/images/design.png",
  ];
  Color mainColor = Color(0xff014c92);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PANSKILL"),
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 16.0),

        backgroundColor: mainColor,
      ),
      body:
      SafeArea(
              child: GridView.builder(
                itemCount: images.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: InkResponse(
                      child: Image.asset(images[index]),
                      onTap: () {
                        print(index);
                      },
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                padding: EdgeInsets.all(10),
                shrinkWrap: true,
              ),
      ),
      drawer: MyDrawerDirectory(),
    );

  }
}
