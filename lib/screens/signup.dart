
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView( // this is for default sticker remove korar jonno jokhon email pass deyar somoy

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start, // left side theke

          children: [
            const SizedBox(
              height: 100,
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
              onTap: (){

                FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailTextController.text, password: _passswordTextController.text)
                .then((value) {
                 FirebaseFirestore.instance
                      .collection('uinfo')
                      .doc(FirebaseAuth.instance.currentUser?.uid)
                      .set(
                    {
                      'email': _emailTextController.text,
                      'name': _nameTextController.text,
                      'img': "",
                      'score': 0,
                    },
                  );

                 
                  print("Created new account");
                   Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const Emailotp(),),);
                }).onError((error, stackTrace) {
                  print("Error ${error.toString()}");
                });
              },

              child:  Padding(
                padding: defaultPadding,
                child:  Buttons(
                  buttonText: "Sign Up",
                ),
              ),

            ),



            const SizedBox(
              height: 30,
            ),

            Padding(
              padding: defaultPadding,
              child: Row(
                children: [
                  Text("Or Sign Up with: ",
                    style: subTitle.copyWith(color: blackColor),
                  ),

                ],
              ),
            ),

            const SizedBox(
              height: 30,
            ),



            // login from google and facebook
            Row(

              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                //for google logo
                MaterialButton(
                    onPressed: (){
                  signInWithGoogle();
                },
                  child:  LogoButtons(
                    iconImage: const Image(
                      height: 30,
                      width: 30,
                      image: AssetImage('assets/google.png'),
                    ),
                    textButtton: ' Google',

                  ),

                ),






              ],
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

  //firebaseAuth using google
  void signInWithGoogle()async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken
    );
   UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
   print(userCredential.user?.displayName);
  }
}


//another login option from google and facebook
class LogoButtons extends StatelessWidget {

  final Image iconImage;
  final String textButtton;

  LogoButtons({required this.iconImage, required this.textButtton});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    return Container(
      height: mediaQuery.height*0.07,
      width: mediaQuery.width * 0.40,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: blackColor),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // google logo center e ashar jonno
        children: [
          iconImage,
          const SizedBox(height: 5,),
          Text(textButtton),
        ],
      ),
    );
  }
}
