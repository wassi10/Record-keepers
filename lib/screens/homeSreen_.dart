import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/features/leaderboard.dart';
import 'package:flutter_new/features/participate_sreen.dart';
import 'package:flutter_new/features/walltet.dart';
import 'package:flutter_new/screens/profile_screen.dart';
import '../pages/survey_Dashboard.dart';
import '../theme.dart';

  @override
class HomeSreeen extends StatefulWidget {

  @override
  State<HomeSreeen> createState() => _HomeSreeenState();
}

class _HomeSreeenState extends State<HomeSreeen> {

  // //for sign out
  // final user = FirebaseAuth.instance.currentUser!;

  int currentTab = 0;
  final List<Widget> screens = [
    ParticipateScreen(),
    Wallet(),
    LeaderBoard(),
    ProfileScreen(),
  ];
  



  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = ParticipateScreen();


 Widget build(BuildContext context) {
    


    return Scaffold(

    
                   

      // drawer: Drawer(
      //   child: Column(
      //     children: [
      //       Container(
      //         width: double.infinity,
      //         padding: defaultPadding,
      //         color: primaryColor,
      //         child: Center(
      //           child: Column(
      //             children: [
      //               Container(
      //                 width: 100,
      //                 height: 100,
      //                 decoration: const BoxDecoration(
      //                     shape: BoxShape.circle
      //                 ),
      //               ),
      //             ],
      //
      //           ),
      //         ),
      //
      //       ),
      //       const SizedBox(
      //         height: 100,
      //       ),
      //
      //       //logout
      //       MaterialButton(
      //         onPressed: (){
      //           FirebaseAuth.instance.signOut();
      //         },
      //         child: const ListTile(
      //           leading: Icon(Icons.arrow_back),
      //           title: Text('Log Out',
      //             style: TextStyle(
      //               fontSize: 18, color: primaryColor,
      //             ),
      //           ),
      //         ),
      //       ),
      //
      //     ],
      //
      //   ),
      // ),


    body: PageStorage(
        bucket: bucket,
      child: currentScreen,
    ),

      //button for create survey screen
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
          onPressed: (){
              
                                    Navigator.push(context, MaterialPageRoute(builder:  (context) => SurveyDashboard(),),);
          },
        child: const Icon(Icons.border_color_outlined, color: whiteColor,),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      //bottomNavigationBar
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,

        child: Container(
          color: primaryColor, // bottom appbar color
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // this button for home that is represents the participate survey dashboard
                  MaterialButton(
                    minWidth: 90,
                      onPressed: () {
                        setState(() {
                          currentScreen = ParticipateScreen();
                          currentTab=0;
                        });
                      },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //home = participate survey
                        Icon(
                          Icons.home, color: currentTab == 0 ? whiteColor : Colors.grey,
                        ),
                        Text('Home', style: TextStyle(color: currentTab == 0 ? whiteColor : Colors.grey,fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),

                  // this button for wallet
                  MaterialButton(
                    minWidth:90,
                    onPressed: () {
                      setState(() {
                        currentScreen = Wallet();
                        currentTab=1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //home = participate survey
                        Icon(
                          Icons.wallet, color: currentTab == 0 ? whiteColor : Colors.grey,
                        ),
                        Text('Wallet', style: TextStyle(color: currentTab == 0 ? whiteColor : Colors.grey,fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),

                 //this button for leaderboard
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = LeaderBoard();
                        currentTab=2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //home = participate survey
                        Icon(
                          Icons.leaderboard, color: currentTab == 0 ? whiteColor : Colors.grey,
                        ),
                        Text('Leader Board', style: TextStyle(color: currentTab == 0 ? whiteColor : Colors.grey,fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  //profile
                  MaterialButton(
                    minWidth: 0,
                    onPressed: () {
                      setState(() {
                        currentScreen = ProfileScreen();
                        currentTab=3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //home = participate survey
                        Icon(
                          Icons.person, color: currentTab == 0 ? whiteColor : Colors.grey,
                        ),
                        Text('Profile', style: TextStyle(color: currentTab == 0 ? whiteColor : Colors.grey,fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

    );
  }
}
