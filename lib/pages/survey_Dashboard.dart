import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/pages/survey_sreen.dart';
import 'package:flutter_new/screens/homeSreen_.dart';

import '../features/leaderboard.dart';
import '../screens/profile_screen.dart';
import '../theme.dart';
import '../widgets/notes.dart';

class SurveyDashboard extends StatefulWidget {
  const SurveyDashboard({Key? key}) : super(key: key);

  @override
  State<SurveyDashboard> createState() => _SurveyDashboardState();
}

class _SurveyDashboardState extends State<SurveyDashboard> {

  final user = FirebaseAuth.instance.currentUser!;

  int currentTab = 0;
  final List<Widget> screens = [
    SurveyScreen(),
    Notes(),
    LeaderBoard(),
    ProfileScreen(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = SurveyScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: PageStorage(
          bucket: bucket,
          child: currentScreen,
        ),

      //button for create survey screen
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white60,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder:  (context) => HomeSreeen(),),);
        },
        child: const Icon(Icons.notes, color: primaryColor,),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,


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
                    minWidth: 70,
                    onPressed: () {
                      setState(() {
                        currentScreen = SurveyScreen();
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
                    minWidth:70,
                    onPressed: () {
                      setState(() {
                        currentScreen = Notes();
                        currentTab=1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //home = participate survey
                        Icon(
                          Icons.sticky_note_2_outlined, color: currentTab == 0 ? whiteColor : Colors.grey,
                        ),
                        Text('Notes', style: TextStyle(color: currentTab == 0 ? whiteColor : Colors.grey,fontWeight: FontWeight.w500),
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
                    minWidth: 40,
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
