
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/theme.dart';
import 'package:flutter_new/widgets/profile_page.dart';

import 'add_survey.dart';

class SurveyScreen extends StatefulWidget {

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(


      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text('Create a survey', style: TextStyle(color: whiteColor), ),

        actions: <Widget>[
          IconButton(
              onPressed: (){},
            icon: Icon(Icons.notifications_none_rounded), color: whiteColor,

          ),
        ],
      ),


      body:  SingleChildScrollView(
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),





            //Create Survey Button
            MaterialButton(
              onPressed: (){

                Navigator.push(context, MaterialPageRoute(builder:  (context) => CreateASurvey(),),);
              },

              child:  Container(

                color: primaryColor,
                height: MediaQuery.of(context).size.height*0.18,
                width: double.infinity,
                alignment: Alignment.center,

                child:   Padding(
                  padding: EdgeInsets.all(20.0),
                  child:Text('Create Survey', style: TextStyle(fontSize: 28,fontFamily: 'poppins', color: whiteColor),

              ),
                ),

            ),
            ),

            SizedBox(
              height: 70,
            ),


            //My data button
            Padding(
              padding: defaultPadding,
              child: Row(
                children: [

                  MaterialButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ProfileScreen(),),);
                    },
                    child: Text(
                        "My Data", style: textButton),
                  ),
                ],

              ),
            ),


          ],


        ),

      ),

    ),

    );
  }
}
