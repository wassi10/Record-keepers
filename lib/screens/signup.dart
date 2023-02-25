
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/screens/otp_screen.dart';
import 'package:flutter_new/screens/send_otp.dart';
import 'package:flutter_new/theme.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../widgets/buttons.dart';
import 'login.dart';


class SignUpScreen extends StatefulWidget {


  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  bool _isObscure = true;

    final _nameTextController = TextEditingController();
    final _emailTextController = TextEditingController();
    final _passswordTextController = TextEditingController();
    EmailOTP myauth = EmailOTP();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView( // this is for default sticker remove korar jonno jokhon email pass deyar somoy

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start, // left side theke

          children: [
            const SizedBox(
              height: 190,
            ),

            Padding(
              padding: defaultPadding,

              child: Text(
                'Create account', style: titleText,
              ),
            ),
            const SizedBox(
              height: 5,
            ),

            Padding(
              padding: defaultPadding,
              child: Row(
                children: [
                  Text(
                    "Already have account?", style: subTitle,),

                  const SizedBox(
                    height: 5,),

                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const LogInScreen(),),);
                    },
                    child: Text(
                        " Sign In", style: textButton),
                  ),
                ],

              ),
            ),

            const SizedBox(
              height: 30,
            ),


            Padding(
              padding: defaultPadding,
              child:  Column(
               children: [
                 BuildInputForm('Name', false, _nameTextController),
                 BuildInputForm('Email', false, _emailTextController),
                 BuildInputForm('Password', true, _passswordTextController),
               ],
              ),
            ),



            const SizedBox(
              height: 40,
            ),


            //Signup button with firebase
            GestureDetector(
              onTap: ()async{ 
                myauth.setConfig(
                          appEmail: "contact@hdevcoder.com",
                          appName: "Email OTP",
                          userEmail: _emailTextController.text,
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
                                builder: (context) =>   OtpScreen(myauth: myauth,_emailTextController.text,_nameTextController.text,_passswordTextController.text)));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Oops, OTP send failed"),
                        ));
                      }

              },

              child:  Padding(
                padding: defaultPadding,
                child:  Buttons(
                  buttonText: "Sign Up",
                ),
              ),

            ),



          ],
        ),
      ),

    );
  }

  Padding BuildInputForm(String hint, bool pass, ctrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        obscureText: pass ? _isObscure: false,

        controller: ctrl,

        decoration: InputDecoration(
            hintText: hint, hintStyle: const TextStyle(color: blackColor),

            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                  color: blackColor),
            ),

            suffixIcon: pass ? IconButton(
              onPressed: () {
                setState(() {
                  _isObscure = ! _isObscure;
                });
              }, icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility, color: primaryColor,),
            ): null
        ),

      ),
    );
  }

}
