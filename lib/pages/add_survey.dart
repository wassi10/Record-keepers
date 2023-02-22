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
  String number = ""; // number of participants
  String title = "";
  String details = "";
  bool _validate = false;
  bool _validate2 = false;
  bool _validate3 = false;
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
                const SizedBox(
                  height: 30,
                ),
                const Text('The Number of Participants',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w600,
                        color: blackColor)),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(10),
                    errorText: _validate2
                        ? "Number of participants can't be empty"
                        : null,
                  ),
                  onChanged: (_val) {
                    number = _val;
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text('Title',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w600,
                        color: blackColor)),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Title',
                    contentPadding: EdgeInsets.all(10),
                    errorText: _validate ? "Title cant be empty" : null,
                  ),
                  onChanged: (_val) {
                    title = _val;
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text('Details',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w600,
                        color: blackColor)),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.30,
                  padding: const EdgeInsets.only(top: 0),

                  //description textformfield
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Type Details',
                      errorText: _validate3 ? "Details cant be empty" : null,
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
          onPressed: () async {
           
              setState(() {
                title.isEmpty ? _validate = true : _validate = false;
              });
            
           
              setState(() {
                number.isEmpty ? _validate2 = true : _validate2 = false;
              });
         
           
              setState(() {
                details.isEmpty ? _validate3 = true : _validate3 = false;
              });
        

            if (!_validate && !_validate2 && !_validate3) {
              final FirebaseAuth auth = FirebaseAuth.instance;
              User? user = auth.currentUser;
              String? uid = user?.uid;

              DocumentReference docRef =
                  FirebaseFirestore.instance.collection('uinfo').doc(uid);
              DocumentSnapshot docSnapshot = await docRef.get();

              //  Object? data = docSnapshot.data();
              // Do something with the data

              String img = docSnapshot['img'];
              String nam = docSnapshot['name'];

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SurveyDuration(number, title, details, img, nam),
                ),
              );
            }
          },
          label: const Text(
            "Next",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
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
