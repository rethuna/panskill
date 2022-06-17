import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:panskill/Model/Services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../screenPanskill/HomePage.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({Key? key}) : super(key: key);

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  String? mobile, token;
  Services servModel = Services(data: []);
  List _loadedPhotos = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadDetails();
  }

  @override
  Widget build(BuildContext context) {
    Color mainColor = Color(0xff014c92);
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        title: Text("PANSKILL"),
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 16.0),
        backgroundColor: mainColor,
      ),
      body: SafeArea(
        child: servModel.data.isEmpty
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
        for (var i = 0; i < servModel.data.length; i++)
          servModel.data[i].icon.toString().endsWith("null")
              ? getStructuredGridCell_(
                  servModel.data[i].name.toString(),
                  "electrical.png",
                )
              : getStructuredGridCell(
                  servModel.data[i].name.toString(),
                  servModel.data[i].icon.toString(),
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

  Future<List<String>> fetchGalleryData() async {
    try {
      final response = await http
          .get(Uri.parse("http://panskillconnect.com/api/services"), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        return compute(parseGalleryData, response.body);
      } else {
        throw Exception('Failed to load');
      }
    } on SocketException catch (e) {
      throw Exception('Failed to load');
    }
  }

  List<String> parseGalleryData(String responseBody) {
    final parsed = List<String>.from(json.decode(responseBody));
    return parsed;
  }

  void getData() async {
    try {
      final response = await http
          .get(Uri.parse("http://panskillconnect.com/api/services"), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 201 || response.statusCode == 200) {
        setState(() {
          Map<String, dynamic> resposne = jsonDecode(response.body);
          servModel = Services.fromJson(resposne);
          _loadedPhotos = servModel.data;
        });
      } else if (response.statusCode == 422) {}
    } catch (e) {
      print(e);
    }
    // var json = jsonDecode(response.body);
  }
}
