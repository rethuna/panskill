import 'package:flutter/material.dart';
import 'package:panskill/screenPanskill/RegisterScreen.dart';
import 'package:panskill/screenPanskill/otpscreen.dart';

class LoginDemo extends StatefulWidget {
  const LoginDemo({Key? key}) : super(key: key);

  @override
  State<LoginDemo> createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  String dialedCodedigits = "+91";
  TextEditingController _controller = new TextEditingController();
  Color mainColor = Color(0xff014c92);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PANSKILL"),
        backgroundColor: mainColor,
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.only(left: 28, right: 28),
            child: Image.asset("asset/images/panlogo.png"),
          ),
          SizedBox(height: 100),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Mobile No',
                    prefixIcon: const Icon(Icons.phone),

                    prefix: Padding(
                      padding: EdgeInsets.all(3),
                      child: Text(dialedCodedigits),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  controller: _controller),
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: mainColor,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 5)),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => OtpControllerScreen(
                                phone: _controller.text,
                                codeDigits: dialedCodedigits,
                              )));
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(width: 25),
                Container(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: mainColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 5)),
                      child: Text('Cancel',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginDemo(),
                        ));
                      }),
                ),
              ],
            ),
          ),
          SizedBox(height: 100),
          Container(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (c) => RegisterDemo()));
              },
              child: new Text("New User Register Here"),
            ),
          )
        ],
      )),
    );
  }
}
