import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/pages/create_survey_question.dart';
import 'package:flutter_new/theme.dart';
import 'dart:core';


class SurveyDuration extends StatefulWidget {

  @override
  State<SurveyDuration> createState() => _SurveyDurationState();
}

class _SurveyDurationState extends State<SurveyDuration> {

  late String chooseCategory = "-1";


  DateTime startDate = DateTime.now();
  DateTime? endDate;

  // defined category



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Survey Duration', style: TextStyle(color: whiteColor), ),
        elevation: 0,
        backgroundColor: primaryColor,
      ),

      body: Padding(
        padding: defaultPadding,
        child: SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children:[

              const SizedBox(
                height: 25,),

              //survey Duration
              const Text('Survey Duration',
                  style: TextStyle(fontSize: 22,fontFamily: 'poppins',
                      fontWeight: FontWeight.w600, color: blackColor)
              ),

              const SizedBox(
                height: 15,
              ),

              const Text('Start',
                  style: TextStyle(fontSize: 18,fontFamily: 'poppins',
                      fontWeight: FontWeight.w400, color: secondaryColor)
              ),

              const SizedBox(
                height: 5,
              ),

              // start date

              Row(
                mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(

                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: startDate,
                            firstDate: DateTime(1980), // start from year 1980
                            lastDate: DateTime(2100), // end year
                        );
                         if(pickedDate != null){
                           setState(() {
                             startDate = pickedDate;
                           });
                         }
                      },


                      child: const Text('Select Date', style: TextStyle(fontSize: 20,fontFamily: 'poppins', color: whiteColor),
                      ),
                  ),

                  Text(
                    '${startDate.day}-${startDate.month}-${startDate.year}',
                    style: const TextStyle(fontSize: 18),
                  ),

                ],
              ),


              const SizedBox(
                height: 25,
              ),

              const Text('End',
                  style: TextStyle(fontSize: 18,fontFamily: 'poppins',
                      fontWeight: FontWeight.w400, color: secondaryColor)
              ),

              const SizedBox(
                height: 5,
              ),

              // end date
              Row(
                mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
                children: [

                  ElevatedButton(

                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: startDate,
                        firstDate: startDate, // start from year 1980
                        lastDate: DateTime(2100), // end year
                      );
                      if(pickedDate != null){
                        setState(() {
                          endDate = pickedDate;
                        });
                      }
                    },

                    child: const Text('Select Date', style: TextStyle(fontSize: 20,fontFamily: 'poppins', color: whiteColor),
                    ),
                  ),


                  Text(
                    endDate == null? 'End Date': '${endDate!.day}-${endDate!.month}-${endDate!.year}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),

              const SizedBox(
                height: 55,
              ),

              const Text('Select a Category',
                  style: TextStyle(fontSize: 18,fontFamily: 'poppins',
                      fontWeight: FontWeight.w600, color: blackColor)
              ),

              const SizedBox(
                height: 20,
              ),

              Card(
                color: Colors.white54,

                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),

                  value: chooseCategory,
                  items: const [
                    DropdownMenuItem(
                      child: Text("  Select Category"), value: "-1",),
                    DropdownMenuItem(
                      child: Text("  Blockchain"), value: "1",),
                    DropdownMenuItem(
                      child: Text("  Entertainment"), value: "2",),
                    DropdownMenuItem(
                      child: Text("  Health"), value: "3",),
                    DropdownMenuItem(
                      child: Text("  Politics"), value: "4",),
                    DropdownMenuItem(
                      child: Text("  Economy"), value: "5",),
                    DropdownMenuItem(
                      child: Text("  Religion"), value: "6",),
                    DropdownMenuItem(
                      child: Text("  Business"), value: "7",),
                    DropdownMenuItem(
                      child: Text("  Education"), value: "8",),
                    DropdownMenuItem(
                      child: Text("  Society"), value: "9",),
                  ],
                  onChanged: (v){},

                ),
                ),

            ],
          ),
        ),

      ),

      //next button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder:  (context) => const CreateSurveyQuestion(),),);
        },
        label: const Text("Next", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),),
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

}
