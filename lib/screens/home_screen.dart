import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/screens/login.dart';
import 'package:flutter_new/theme.dart';
import '../widgets/notes.dart';

import 'dart:async';
import '../widgets/profile_page.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

    //for sign out
  final user = FirebaseAuth.instance.currentUser!;


@override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Home page', style: TextStyle(color: whiteColor), ),
        elevation: 30,
        backgroundColor: primaryColor,
      ),

      drawer: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: defaultPadding,
              color: primaryColor,
              child: Center(
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle
                      ),


                    ),

                  ],

                ),
              ),

            ),



            // ListTile(
            //   leading: Icon(Icons.edit_note),
            //   title: Text('Profile',
            //   style: TextStyle(
            //     fontSize: 20, color: primaryColor,
            //   ),
            // ),
            //
            //   onTap: (){
            //     Navigator.push(context, MaterialPageRoute(builder:  (context) => ProfileScreen(),),);
            //   },
            // ),

            SizedBox(
              height: 100,
            ),

            MaterialButton(
                onPressed: (){
                  FirebaseAuth.instance.signOut();
                },
              // color: Colors.blue,
              // child: Text('Sign out'),

              child: ListTile(
                leading: Icon(Icons.arrow_back),
                title: Text('Log Out',
                  style: TextStyle(
                    fontSize: 18, color: primaryColor,
                  ),
                ),
              ),
            ),

          ],

        ),
      ),

      
      body: GridView.count(

        padding: EdgeInsets.all(30),
          crossAxisCount: 2,

        children: <Widget>[


          //Create Survey
          Card(
            color: Colors.white70,
            margin: EdgeInsets.all(8),
            child: GestureDetector(
              onTap: (){
                //Navigator.push(context, MaterialPageRoute(builder:  (context) => ProfileScreen(),),);

              },
              child: Center(
                child: Column(

                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image(
                      height: 80,
                    width: 80,
                    image: AssetImage('assets/survey-icon.png'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Create Survey', style: TextStyle(fontSize: 15),),
                  ],
                ),
              ),
            ),

          ),

        // participate Survey card
          Card(
            color: Colors.white70,
            margin: EdgeInsets.all(8),
            child: GestureDetector(
              onTap: (){
                //Navigator.push(context, MaterialPageRoute(builder:  (context) => ProfileScreen(),),);

              },
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image(
                      height: 80,
                      width: 80,
                      image: AssetImage('assets/participate.png'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Participate Survey', style: TextStyle(fontSize: 15),),
                  ],
                ),
              ),
            ),

          ),


          // for notes
          Card(
            color: Colors.white70,
            margin: EdgeInsets.all(8),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:  (context) => Notes(),),);
              },

              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image(
                      height: 80,
                      width: 80,
                      image: AssetImage('assets/notes.png'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Notes', style: TextStyle(fontSize: 15),),
                  ],
                ),
              ),
            ),

          ),




        ],
      ),
    );
  }
}
