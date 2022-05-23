import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panskill/screenPanskill/homescreen.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OtpControllerScreen extends StatefulWidget {
  final String phone;
  final String codeDigits;

  OtpControllerScreen({required this.phone, required this.codeDigits});

  @override
  State<OtpControllerScreen> createState() => _OtpControllerScreenState();
}

class _OtpControllerScreenState extends State<OtpControllerScreen> {
  Color mainColor = Color(0xff014c92);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _pinOtpcontroller = TextEditingController();
  final FocusNode _pintOTPcodefocus = FocusNode();
  String? verificationCode;
  final BoxDecoration _pinOTPcodedecoration = BoxDecoration(
      color: Colors.blueAccent,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.grey));

  @override
  void initState() {
    super.initState();
    verifyPhonenumber();
  }

  verifyPhonenumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "${widget.codeDigits + widget.phone}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) {
            if (value != null) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (c) => HomeScreen()));
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.message.toString()),
            duration: Duration(seconds: 3),
          ));
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          setState(() {
            verificationCode = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationCode = verificationId;
        },
        timeout: Duration(seconds: 60));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PANSKILL"),
        backgroundColor: mainColor,
      ),
      key: scaffoldKey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("asset/images/otp.png"),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Center(
              child: GestureDetector(
                onTap: () {},
                child: Text(
                  "Verifying: ${widget.codeDigits}${widget.phone}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(40.0),
            child: PinPut(
              fieldsCount: 6,
              textStyle: TextStyle(fontSize: 25.0, color: Colors.white),

              eachFieldWidth: 40.0,
              eachFieldHeight: 55.0,
              focusNode: _pintOTPcodefocus,
              controller: _pinOtpcontroller,
              submittedFieldDecoration: _pinOTPcodedecoration,
              selectedFieldDecoration: _pinOTPcodedecoration,
              followingFieldDecoration: _pinOTPcodedecoration,
              pinAnimationType: PinAnimationType.rotation,
              onSubmit: (pin) async {
                try {
                  await FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider.credential(
                          verificationId: verificationCode!, smsCode: pin))
                      .then((value) {
                    if (value != null) {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (c) => HomeScreen()));
                    }
                  });
                } catch (e) {
                  FocusScope.of(context).unfocus();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Invalid OTP"),
                    duration: Duration(seconds: 3),
                  ));
                  print(e);
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
