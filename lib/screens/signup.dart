
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            SizedBox(
              height: 100,
            ),

            Padding(
              padding: defaultPadding,

              child: Text(
                'Create account', style: titleText,
              ),
            ),
            SizedBox(
              height: 5,
            ),

            Padding(
              padding: defaultPadding,
              child: Row(
                children: [
                  Text(
                    "Already have account?", style: subTitle,),

                  SizedBox(
                    height: 5,),

                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => LogInScreen(),),);
                    },
                    child: Text(
                        " Sign In", style: textButton),
                  ),
                ],

              ),
            ),

            SizedBox(
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



            SizedBox(
              height: 40,
            ),


            //Signup button with firebase
            GestureDetector(
              onTap: (){

                FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailTextController.text, password: _passswordTextController.text).then((value) {
                  print("Created new account");
                   Navigator.push(context, MaterialPageRoute(
                    builder: (context) => LogInScreen(),),);
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



            SizedBox(
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

            SizedBox(
              height: 30,
            ),



            // login from google and facebook
            Row(

              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                //for google logo



               LogoButtons(
                  iconImage: Image(
                    height: 30,
                    width: 30,
                    image: AssetImage('assets/google.png'),
                  ),
                  textButtton: ' Google',

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
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        obscureText: pass ? _isObscure: false,

        controller: ctrl,

        decoration: InputDecoration(
            hintText: hint, hintStyle: TextStyle(color: blackColor),

            focusedBorder: UnderlineInputBorder(
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
  // void signInWithGoogle()async {
  //   GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //   GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  //   AuthCredential credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken
  //   );
  //  UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
  //  print(userCredential.user?.displayName);
  // }
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
          SizedBox(height: 5,),
          Text(textButtton),
        ],
      ),
    );
  }
}
