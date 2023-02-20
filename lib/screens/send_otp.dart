import 'package:email_otp/email_otp.dart';

import 'package:flutter/material.dart';
import 'package:flutter_new/theme.dart';

import 'otp_screen.dart';

class Emailotp extends StatefulWidget {
  const Emailotp({Key? key}) : super(key: key);

  @override
  State<Emailotp> createState() => _EmailotpState();
}

class _EmailotpState extends State<Emailotp> {

  TextEditingController email = TextEditingController();
  EmailOTP myauth = EmailOTP();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: defaultPadding,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(
                height: 250,
              ),
              Text(
                "Enter your Email",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: primaryColor),
              ),

              SizedBox(height: 30,),

              TextFormField(
                controller: email,
                decoration: InputDecoration(

                  suffixIcon: IconButton(
                    onPressed: () async {
                      myauth.setConfig(
                          appEmail: "contact@hdevcoder.com",
                          appName: "Email OTP",
                          userEmail: email.text,
                          otpLength: 4,
                          otpType: OTPType.digitsOnly);
                      if (await myauth.sendOTP() == true) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("OTP has been sent"),
                        ));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>   OtpScreen(myauth: myauth,)));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Oops, OTP send failed"),
                        ));
                      }
                    },
                    icon: const Icon(
                      Icons.send_rounded,
                      color: primaryColor,
                    ),
                  ),
                  hintText: "Enter Email",

                ),
              ),


            ]
        ),
      ),
    );
  }
}
