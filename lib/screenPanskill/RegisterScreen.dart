import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../Database/DatabaseHelper.dart';

class RegisterDemo extends StatefulWidget {
  const RegisterDemo({Key? key}) : super(key: key);

  @override
  State<RegisterDemo> createState() => _RegisterDemoState();
}

class _RegisterDemoState extends State<RegisterDemo> {
  TextEditingController _controller_username = new TextEditingController();
  TextEditingController _controller_password = new TextEditingController();
 // final dbHelper = DatabaseHelper.instance;

  Color mainColor = Color(0xff014c92);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PANSKILL"),
        backgroundColor: mainColor,
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 16.0) ,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 130),
          Padding(
            padding: const EdgeInsets.only(left: 28, right: 28),
            child: Image.asset("asset/images/panlogo.png"),
          ),
          Container(
            margin: EdgeInsets.only(top: 50),
            child: Center(
              child: Text(
                "Register",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: mainColor),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              icon: Icon(
                Icons.work,
                color: mainColor,
                size: 30.0,
              ),
              label: Text('SKILLED WORKER',
                  style:
                      TextStyle(color: mainColor, fontWeight: FontWeight.normal)),
              onPressed: () {
                _onAlertWithCustomContentPressed(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onSurface: mainColor,
                side: BorderSide(color: mainColor, width: 1),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
            ),
          ),
          SizedBox(height: 5),
          Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              icon: Icon(
                Icons.account_box,
                color: mainColor,
                size: 30.0,
              ),
              label: Text('CUSTOMER',
                  style:
                      TextStyle(color: mainColor, fontWeight: FontWeight.normal)),
              onPressed: () {
                _onAlertWithCustomContentPressed(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onSurface: mainColor,
                side: BorderSide(color: mainColor, width: 1),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
            ),
          ),
          new Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }

// Alert custom content
  _onAlertWithCustomContentPressed(context) {
    Alert(
        context: context,
        title: "Register Here",
        content: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.account_circle),
                labelText: 'Username',
              ),
                controller: _controller_username
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: 'Password',
              ),
                controller: _controller_password
            ),
          ],
        ),
        buttons: [
          DialogButton(
            color: mainColor,
           // onPressed:_insert(_controller_username.text,_controller_password.text),
            child: Text(
              "REGISTER",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
  // Button onPressed methods
   /*_insert(String user,String pswd) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.colUName : user,
      DatabaseHelper.colPassword  : pswd
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }*/
}
