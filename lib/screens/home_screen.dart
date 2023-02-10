import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/pages/survey_sreen.dart';
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
        title: const Text('Home page', style: TextStyle(color: whiteColor), ),
        elevation: 0,
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
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle
                      ),


                    ),

                  ],

                ),
              ),

            ),


            const SizedBox(
              height: 100,
            ),

            //logout
            MaterialButton(
                onPressed: (){
                  FirebaseAuth.instance.signOut();
                },
              child: const ListTile(
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

        padding: const EdgeInsets.all(30),
          crossAxisCount: 2,

        children: <Widget>[



          //Create Survey
          Card(
            color: Colors.white70,
            margin: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:  (context) => SurveyScreen(),),);

              },
              child: Center(
                child: Column(

                  mainAxisSize: MainAxisSize.min,
                  children: const [
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
            margin: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:  (context) => const ProfileScreen(),),);

              },
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
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
            margin: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:  (context) => Notes(),),);
              },

              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
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

          //wallets
          Card(
            color: Colors.white70,
            margin: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: (){
                // Navigator.push(context, MaterialPageRoute(builder:  (context) => Notes(),),);
              },

              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Image(
                      height: 80,
                      width: 80,
                      image: AssetImage('assets/wallet.png'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('LeaderBoard', style: TextStyle(fontSize: 15),),
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
