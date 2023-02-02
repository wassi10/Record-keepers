
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/pages/survey_duration.dart';
import 'package:flutter_new/theme.dart';

class CreateASurvey extends StatefulWidget {

  @override
  State<CreateASurvey> createState() => _CreateASurveyState();
}

class _CreateASurveyState extends State<CreateASurvey> {


  late String number; // number of participants
  late String title;
  late String details;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        appBar: AppBar(
          elevation: 0,
          backgroundColor: primaryColor,
        ),

        body: Padding(
          padding: defaultPadding,

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,),

                Text('The Number of Participants',
                    style: TextStyle(fontSize: 18, fontFamily: 'poppins',
                        fontWeight: FontWeight.w600, color: blackColor)),

                SizedBox(
                  height: 20,
                ),

                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(10),
                  ),
                  onChanged: (_val) {
                    number = _val;
                  },
                ),

                SizedBox(
                  height: 40,
                ),

                Text('Title',
                    style: TextStyle(fontSize: 18, fontFamily: 'poppins',
                        fontWeight: FontWeight.w600, color: blackColor)),

                SizedBox(
                  height: 15,
                ),

                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Title',
                    contentPadding: EdgeInsets.all(10),
                  ),
                  onChanged: (_val) {
                    title = _val;
                  },
                ),

                SizedBox(
                  height: 40,
                ),

                Text('Details',
                    style: TextStyle(fontSize: 18, fontFamily: 'poppins',
                        fontWeight: FontWeight.w600, color: blackColor)),

                SizedBox(
                  height: 15,
                ),

                Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.30,
                  padding: EdgeInsets.only(top: 0),

                  //description textformfield
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Type Details',
                    ),

                    onChanged: (_val) {
                      details = _val;
                    },
                    maxLines: 25,
                  ),
                ),

              ],

            ),


          ),

        ),

        floatingActionButton: FloatingActionButton.extended(
          onPressed: //add,
              (){

            Navigator.push(context, MaterialPageRoute(builder:  (context) => SurveyDuration(),),);
          },

          label: Icon(Icons.save_rounded),
          backgroundColor: primaryColor,
        ),

      ),
    );
  }

  //firestore

  // void add() async {
  //   //save to firestore
  //   CollectionReference ref = FirebaseFirestore.instance.collection(
  //       'surveyInfo').doc(FirebaseAuth.instance.currentUser?.uid).collection(
  //       'information');
  //
  //   var data = {
  //     'participantsNumber': number,
  //     'title': title,
  //     'description': details,
  //   };
  //   ref.add(data);
  //
  //   Navigator.push(context, MaterialPageRoute(
  //     builder: (context) => SurveyDuration(),),);
  // }

}



