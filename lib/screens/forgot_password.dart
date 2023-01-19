
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/theme.dart';
import '../widgets/buttons.dart';

class ForgotPasswordScreen extends StatefulWidget {

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
  Future passwordReset() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text('Check your email to reset password!'),
        );
      });
    } on FirebaseAuthException catch(e){
      print(e);
      showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text(e.message.toString()),
        );
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
      ),

      body: Padding(
        padding: defaultPadding,

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              SizedBox(
                height: 190,
              ),
              Text(
                'Reset Password', style: titleText,
              ),

              SizedBox(
                height: 10,
              ),

              Text(
                'Please Enter your email address', style: subTitle,
              ),

              SizedBox(
                height: 30,
              ),

              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Email', hintStyle: TextStyle(color: blackColor),

                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: blackColor),),
                ),
              ),

              SizedBox(
                height: 40,
              ),


              //Reset password button
              MaterialButton(
                  onPressed:  passwordReset,
                child: Buttons(
                      buttonText: 'Reset Password',
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}

