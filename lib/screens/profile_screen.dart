import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/screens/change_pass.dart';

import '../theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //for sign out
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: whiteColor), ),
        elevation: 0,
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false, // this is for remove the back button
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 350,
            ),

            //change password
            MaterialButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder:  (context) => ChangePassword(),),);
              },
              child: const ListTile(
                // leading: Icon(Icons.arrow_back_ios_sharp),
                title: Text(' Change Password',
                  style: TextStyle(
                      fontFamily: 'poppins',fontSize: 20, color: blackColor, fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ),


            //logout button
            MaterialButton(
              onPressed: (){
                FirebaseAuth.instance.signOut();
              },
              child: const ListTile(
                leading: Icon(Icons.arrow_back_ios_sharp),
                title: Text('  Log Out',
                  style: TextStyle(
                      fontFamily: 'poppins',fontSize: 20, color: blackColor, fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ),
          ],

        ),

      ),
    );
  }
}
