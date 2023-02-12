
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/theme.dart';
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
        title: const Text('Create a survey', style: TextStyle(color: whiteColor), ),

        automaticallyImplyLeading: false, // this is for remove the back button
        actions: <Widget>[
          IconButton(
              onPressed: (){},
            icon: const Icon(Icons.notifications_none_rounded), color: whiteColor,

          ),
        ],
      ),


      body:  SingleChildScrollView(
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 100,
            ),


            //Create Survey Button
            MaterialButton(
              onPressed: (){

                Navigator.push(context, MaterialPageRoute(builder:  (context) => CreateASurvey(),),);
              },

              child:  Container(

                // color: primaryColor,
                width: MediaQuery.of(context).size.width,
                height: 180,
                // width: double.infinity,
                alignment: Alignment.center,

                decoration: BoxDecoration( color: primaryColor,borderRadius: BorderRadius.circular(25),),

                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child:Text('Create Survey', style: TextStyle(fontSize: 28,fontFamily: 'poppins', color: whiteColor),
                      ),
                ),

            ),
            ),

            const SizedBox(
              height: 70,
            ),


            //My data button
            Padding(
              padding: defaultPadding,
              child: Row(
                children: [

                  MaterialButton(
                    onPressed: (){

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
