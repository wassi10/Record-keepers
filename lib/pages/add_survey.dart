
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/theme.dart';

class CreateASurvey extends StatefulWidget {

  @override
  State<CreateASurvey> createState() => _CreateASurveyState();
}

class _CreateASurveyState extends State<CreateASurvey> {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,),
                Text('The Number of Participants',
                    style: TextStyle(fontSize: 18,fontFamily: 'poppins',
                        fontWeight: FontWeight.w500, color: blackColor)),

                SizedBox(
                  height: 20,
                ),

                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(5),
                      ),

                  ),

                ),


              ],

            ),

          ),


    ),
    );
  }
}
