import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:panskill/Model/Buisiness.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../screenPanskill/HomePage.dart';
import 'gridview.dart';

class BusinessPage extends StatefulWidget {
  const BusinessPage({Key? key}) : super(key: key);

  @override
  State<BusinessPage> createState() => _BusinessPageState();
}

class _BusinessPageState extends State<BusinessPage> {
  String? mobile, token;
  Business buisModel = Business(data: []);
  List _loadedPhotos = [];

  @override
  void initState() {
    super.initState();
    _loadDetails();
  }

  @override
  Widget build(BuildContext context) {
    Color mainColor = Color(0xff014c92);
    MyGridView myGridView = new MyGridView();
    return Scaffold(
      appBar: AppBar(
        title: Text("PANSKILL"),
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 16.0),
        backgroundColor: mainColor,
      ),
      body: SafeArea(
        child: buisModel.data.isEmpty
            ? const Center(child: CircularProgressIndicator())
        // The ListView that displays photos
            : _build(),
      ),
      drawer: MyDrawerDirectory(),
    );
  }

  GestureDetector getStructuredGridCell_(name, image) {
    // Wrap the child under GestureDetector to setup a on click action
    return GestureDetector(
      onTap: () {
        print("onTap called.");
      },
      child: Card(
          elevation: 2,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: Image(
                        image: AssetImage('data_repo/images/' + image)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(name,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                        style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.normal,
                            fontSize: 12)),
                  ),
                )
              ],
            ),
          )),
    );
  }

  GestureDetector getStructuredGridCell(name, image) {
    // Wrap the child under GestureDetector to setup a on click action
    return GestureDetector(
      onTap: () {

        print("onTap called.$name");
      },
      child: Card(
          elevation: 2,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: image.toString().contains("svg")
                        ? SvgPicture.network(image.toString(),
                        height: 50, width: 50, fit: BoxFit.fill)
                        : Image(
                        image: NetworkImage(image.toString()),
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(name,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.normal,
                            fontSize: 12)),
                  ),
                )
              ],
            ),
          )),
    );
  }


  GridView _build() {
    return GridView.count(
      primary: true,
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
      crossAxisCount: 3,
      childAspectRatio: 0.85,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
      children: <Widget>[
        for (var i = 0; i < buisModel.data.length; i++)
          buisModel.data[i].icon.toString().endsWith("null")
              ? getStructuredGridCell_(
            buisModel.data[i].name.toString(),
            "electrical.png",
          )
              : getStructuredGridCell(
            buisModel.data[i].name.toString(),
            buisModel.data[i].icon.toString(),
          ),
      ],
    );
  }

  _loadDetails() async {
    print('inside save preference');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mobile = (prefs.getString('mobile') ?? '');
    token = (prefs.getString('token') ?? '');
    getData();
  }

  void getData() async {
    try {
      final response = await http
          .get(Uri.parse("http://panskillconnect.com/api/business_categories"), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 201 || response.statusCode == 200) {
        setState(() {
          Map<String, dynamic> resposne = jsonDecode(response.body);
          buisModel = Business.fromJson(resposne);
          _loadedPhotos = buisModel.data;
        });
      } else if (response.statusCode == 422) {

      }
    } catch (e) {
      print(e);
    }
    // var json = jsonDecode(response.body);
  }
}
