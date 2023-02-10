import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
              height: 400,
            ),

            MaterialButton(
              onPressed: (){
                FirebaseAuth.instance.signOut();
              },
              child: const ListTile(
                leading: Icon(Icons.arrow_back),
                title: Text('Log Out',
                  style: TextStyle(
                    fontSize: 20, color: primaryColor, fontWeight: FontWeight.w700
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
