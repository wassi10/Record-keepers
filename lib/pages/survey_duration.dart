import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/features/walltet.dart';

import 'package:flutter_new/screens/homeSreen_.dart';
import 'package:flutter_new/screens/login.dart';
import 'package:flutter_new/theme.dart';
import 'dart:core';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:uuid/uuid.dart';

import 'dart:convert';

import '../features/participate_sreen.dart';

class SurveyDuration extends StatefulWidget {
  SurveyDuration(this.number, this.title, this.details, this.img, this.nam,
      {Key? key})
      : super(key: key);
  dynamic number, title, details, img, nam;
  @override
  State<SurveyDuration> createState() => _SurveyDurationState();
}

class _SurveyDurationState extends State<SurveyDuration> {

  late String chooseCategory = "-1";
  DateTime? startDate = DateTime.now();
  DateTime? endDate;
  late String url;



  @override
  Widget build(BuildContext context) {
    var uuid = Uuid();
   
   var cd = uuid.v4();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Survey Duration',
          style: TextStyle(color: whiteColor),
        ),
        elevation: 0,
        backgroundColor: primaryColor,
      ),

      body: Padding(
        padding: defaultPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),

              //survey Duration
              const Text('Survey Duration',
                  style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w600,
                      color: blackColor)),

              const SizedBox(
                height: 15,
              ),

              const Text('End Date',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w400,
                      color: secondaryColor)),

              const SizedBox(
                height: 5,
              ),

              // start date

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [],
              ),
              const SizedBox(
                height: 10,
              ),

          
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                      ),
                      onPressed: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2010),
                          lastDate: DateTime(2025),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: primaryColor, // <-- SEE HERE
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (pickedDate != null) {
                          setState(() {
                            endDate = pickedDate;
                          });
                        }
                      },
                      child: Text(
                        endDate == null
                            ? 'End Date'
                            : '${endDate!.day}-${endDate!.month}-${endDate!.year}',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'poppins',
                            color: whiteColor),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 55,
              ),
              Text('Go To your Google form In which you\'ve added question and follow: ',
            
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w600,
                      color: blackColor)),

            Text(' Settings-> Pressentation -> Confirm msg , in Confirm msg add this unique code',
            
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w600,
                      color: blackColor)),

                       Text(cd,
            
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w700,
                      color: Colors.green)),

                
                 Text('this is for our tracking purpose',
            
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w600,
                      color: blackColor)),

                   
              const SizedBox(
                height: 55,
              ),

              const Text(
                  'Upload any form url where your Survey questions are added:',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w600,
                      color: blackColor)),

              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: "Paste url...",
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(10),

                ),
                onChanged: (_val) {
                  url = _val;
                },
              ),


            ],
          ),
        ),
      ),

      //next button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final FirebaseAuth auth = FirebaseAuth.instance;
          User? user = auth.currentUser;
          String? uid = user?.uid;

          DocumentReference docRef =
              FirebaseFirestore.instance.collection('uinfo').doc(uid);
          DocumentSnapshot docSnapshot = await docRef.get();

          //  Object? data = docSnapshot.data();
          // Do something with the data

          int co = docSnapshot['score'];
          //int co = int.parse(Coins);

          if (co >= 20) {
            co -= 20;
            _uupdate(co);
            CollectionReference ref = FirebaseFirestore.instance
                .collection('surveyInfo')
                .doc(FirebaseAuth.instance.currentUser?.uid)
                .collection('information');

            CollectionReference reef =
                FirebaseFirestore.instance.collection('survey');

            var data = {
              'name': widget.nam,
              'image': widget.img,
              'startDate': startDate,
              'endDate': endDate,
              'title': widget.title,
              'details': widget.details,
              'number': int.parse(widget.number),
              'url': url,
              'unid': cd,
              'cnt': 0,
            };
            ref.add(data);
            reef.add(data);
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Color.fromRGBO(158, 158, 158, 1),
                          ),
                          Text("Survey Created"),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                //primary: Colors.purple,
                                backgroundColor: primaryColor,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeSreeen(),
                                  ),
                                );
                              },
                              child: Text("Continue"))
                        ],
                      ),
                    ));
          } else {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.dangerous,
                            color: Colors.red,
                          ),
                          Text(
                              "You Do not have sufficiant coins to Create a survey.Do buy or participate in Surveys to earn coins"),
                          Row(children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  //primary: Colors.purple,
                                  backgroundColor: primaryColor,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Wallet(),
                                    ),
                                  );
                                },
                                child: Text("Buy Coin")),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  //primary: Colors.purple,
                                  backgroundColor: primaryColor,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeSreeen(),
                                    ),
                                  );
                                },
                                child: Text("Participate in surveys"))
                          ])
                        ],
                      ),
                    ));
          }
        },
        label: const Text(
          "Next",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        backgroundColor: primaryColor,
      ),
    );
  }

  // void add() async {
  //   //save to firestore
  //   CollectionReference ref = FirebaseFirestore.instance.collection(
  //       'surveyInfo').doc(FirebaseAuth.instance.currentUser?.uid).collection(
  //       'information');
  //
  //   var data = {
  //     'Category': chooseCategory,
  //     'startDate': startDate,
  //     'endDate': endDate,
  //   };
  //   ref.add(data);
  //
  //   Navigator.push(context, MaterialPageRoute(
  //     builder: (context) => CreateSurveyQuestion(),),);
  // }
  // selected;

  Future<void> _uupdate(int co) async {
    CollectionReference ref = FirebaseFirestore.instance.collection('uinfo');

    await ref.doc(FirebaseAuth.instance.currentUser?.uid).update({"score": co});
  }
}
