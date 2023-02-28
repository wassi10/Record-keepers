import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_new/screens/buttons.dart';
import 'package:flutter_new/screens/login.dart';
import '../theme.dart';

class Otp extends StatelessWidget {
  const Otp({
    Key? key,
    required this.otpController,
  }) : super(key: key);

  final TextEditingController otpController; 

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextFormField(
        controller: otpController,
        keyboardType: TextInputType.number,
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty) {
            FocusScope.of(context).previousFocus();
          }
        },
        decoration: const InputDecoration(
          hintText: ('0'),
        ),
        onSaved: (value) {},
      ),
    );
  }
}

class OtpScreen extends StatefulWidget {
   OtpScreen(this.email,this.name,this.pass,{Key? key, required this.myauth}) : super(key: key);
  final EmailOTP myauth;
  String email, name,pass;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otp1Controller = TextEditingController();
  TextEditingController otp2Controller = TextEditingController();
  TextEditingController otp3Controller = TextEditingController();
  TextEditingController otp4Controller = TextEditingController();
  String otpController = "1234";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Enter OTP',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        elevation: 0,
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: defaultPadding,
        child: Column(
          children: [
            const SizedBox(
              height: 150,
            ),
            const Text(
              "Enter OTP",
              style: TextStyle(
                  fontSize: 25,
                  color: primaryColor,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Otp(
                  otpController: otp1Controller,
                ),
                Otp(
                  otpController: otp2Controller,
                ),
                Otp(
                  otpController: otp3Controller,
                ),
                Otp(
                  otpController: otp4Controller,
                ),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            MaterialButton(
              onPressed: () async {
                if (await widget.myauth.verifyOTP(
                        otp: otp1Controller.text +
                            otp2Controller.text +
                            otp3Controller.text +
                            otp4Controller.text) ==
                    true) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("OTP is verified"),
                  ));
                 
     FirebaseAuth.instance.createUserWithEmailAndPassword(email: widget.email, password: widget.pass)
                .then((value) {
                 FirebaseFirestore.instance
                      .collection('uinfo')
                      .doc(FirebaseAuth.instance.currentUser?.uid)
                      .set(
                    {
                      'email': widget.email,
                      'name': widget.name,
                      'img': "",
                      'score': 20,
                    },
                  );

                 
                  print("Created new account");
                   Navigator.push(context, MaterialPageRoute(
                    builder: (context) => LogInScreen(),),);
                }).onError((error, stackTrace) {
                  print("Error ${error.toString()}");
                });


                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Invalid OTP"),
                  ));
                }
              },
              child: Buttons(buttonText: 'Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}
