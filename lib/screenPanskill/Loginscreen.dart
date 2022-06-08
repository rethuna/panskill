import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:panskill/screenPanskill/RegisterScreen.dart';
import 'package:http/http.dart' as http;
import 'package:panskill/screenPanskill/verify_otp.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoginDemo extends StatefulWidget {
  const LoginDemo({Key? key}) : super(key: key);

  @override
  State<LoginDemo> createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  String dialedCodedigits = "+91";
  TextEditingController mobileNumber = TextEditingController();
  bool isLoading = true;
  Color mainColor = Color(0xff014c92);

  void getData() async {
    String otp = OTP(4);
    final response = await http.post(
        Uri.parse("https://sapteleservices.com/SMS_API/sendsms.php"),
        body: ({
          'username': "panskill",
          'password': "d99140",
          'mobile': dialedCodedigits + mobileNumber.text,
          'sendername': "PASKCO",
          'message': "The OTP for your registration at Pan Skill Connect is " +
              otp +
              ".Please submit for phone number verification.PANSKILL CONNECT PRIVATE LIMITED.",
          'routetype': "1",
          'tid': "1607100000000187941"

        }));
    if (response.statusCode == 200) {

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (c) =>
          VerifyOTPScreen(
              mobile: dialedCodedigits + " " + mobileNumber.text, otp: otp)));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Invalid credential")));
    }
    // var json = jsonDecode(response.body);
    setState(() {
      // _data = Users.fromJson(json);
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PANSKILL"),
        backgroundColor: mainColor,
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 16.0) ,
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
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Mobile No',
                      prefixIcon: const Icon(Icons.phone),
                      prefix: Padding(
                        padding: EdgeInsets.all(3),
                        child: Text(dialedCodedigits),
                      ),
                      border: const OutlineInputBorder(),
                    ),
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    controller: mobileNumber),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: mainColor,
                            padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 5)),
                        onPressed: () {
                          if(mobileNumber.text==""){
                            showToast("Enter mobile number");
                          }else{
                            getData();
                          }
                        },
                        child: const Text(
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
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => RegisterDemo()));
                  },
                  child: new Text("New User Register Here"),
                ),
              )
            ],
          )),
    );
  }
}
void showToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor:  Color(0xff014c92),
      textColor: Colors.white,
      fontSize: 16.0);
}
String OTP(int len) {
  var rndnumber = "";
  var rnd = new Random();
  for (var i = 0; i < len; i++) {
    rndnumber = rndnumber + rnd.nextInt(9).toString();
  }
  print(rndnumber);
  return rndnumber;
}
