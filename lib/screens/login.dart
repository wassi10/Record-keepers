

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/screens/signup.dart';
import 'package:flutter_new/theme.dart';
import '../widgets/buttons.dart';
import 'forgot_password.dart';
import 'home_screen.dart';


class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {

  bool _isObscure = true;

  final _emailTextController = TextEditingController();
  final _passswordTextController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(

        padding: defaultPadding, //define in theme.dart file

        child: SingleChildScrollView( // this is for default sticker remove korar jonno jokhon email pass deyar somoy

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // left side theke

            children: [

              SizedBox(
                height: 150, //top to bottom
              ),

              //welcome tittle
              Text(
                'Welcome Back', style: titleText,),

              SizedBox(
                height: 20,
              ),


              buildInputForm('Enter Email', false, _emailTextController),
              buildInputForm('Enter Password', true, _passswordTextController),



              SizedBox(
                height: 15,
              ),


              // forgot password
              GestureDetector(

                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ForgotPasswordScreen(),),);
                },
                child: Text(
                  "Forgot password?", style: TextStyle(
                  color: blackColor, fontSize: 14, decorationThickness: 1,
                ),
                ),
              ),


              SizedBox(
                height: 30,
              ),


              //firebase login
              GestureDetector(

                onTap: (){
                  FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailTextController.text, password: _passswordTextController.text).then((value) {
                    print("Login Successfully");
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => HomeScreen(),),);

                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");

                    showDialog(context: context, builder: (context){
                      return AlertDialog(
                        content: Text('Incorrect email or password, please try again'),
                      );
                    });
                  });
                },
                child:  Buttons(
                  buttonText: "Sign In",
                ),
              ),


              SizedBox(
                height: 20,),



              // don't have any account and signup
              Row(
                children: [
                  Text(
                    "     Don't have any account?", style: subTitle,),

                  SizedBox(
                    height: 5,),

                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => SignUpScreen(),),);
                    },
                    child: Text(
                        " Sign Up", style: textButton),
                  ),
                ],
              ),


            ],
          ),
        ),

      ),

    );
  }


  Padding buildInputForm(String label, bool pass, ctrl) {
    return Padding(

      padding: EdgeInsets.symmetric(vertical: 5),


      child: TextFormField(

        obscureText: pass ? _isObscure: false,

        controller: ctrl,

        decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
                color: blackColor
            ),

            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: blackColor),
            ),

            suffixIcon: pass ? IconButton(
              onPressed: () {
                setState(() {
                  _isObscure = ! _isObscure;
                });
              },
              icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility, color: primaryColor,),
            ): null

        ),

      ),
    );
  }
}

