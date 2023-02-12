import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/widgets/buttons.dart';
import '../theme.dart';
import 'login.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  final _formKey = GlobalKey<FormState>();

  var newPass = " ";
  final newPassController = TextEditingController();

  @override
  void dispose(){
    newPassController.dispose();
    super.dispose();
  }
  final user = FirebaseAuth.instance.currentUser;

  changePass()async{
    try{
      await user!.updatePassword(newPass);
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(context, MaterialPageRoute(builder:  (context) => LogInScreen(),),);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: whiteColor,
          content: Text('Password has been changed, Login Again!'),),);
    }catch(error){}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false, // this is for remove the back button
      ),

      body: Form(
        key: _formKey,
      child: Padding(padding: defaultPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(
                height: 250,
              ),

               TextFormField(
                 controller: newPassController,
                decoration: const InputDecoration(
                  hintText: "Type new password",
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(10),
                ),

                 validator: (value){
                   if(value == null || value.isEmpty){
                     return 'Please Enter password';
                   }
                   return null;
                 },

              ),


              const SizedBox(
                height: 30,
              ),


              //change pass
              MaterialButton(
                onPressed: (){

                  if(_formKey.currentState!.validate()){
                    setState(() {
                      newPass = newPassController.text;
                    });
                    changePass();
                  }
                },

                child:Buttons(buttonText: "Confirm") ,
              ),

            ],

          ),

        ),

      ),
    ),

    );
  }
}
