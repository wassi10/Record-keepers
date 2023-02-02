import 'package:flutter/material.dart';

import '../theme.dart';
import 'make_payments.dart';

class CreateSurveyQuestion extends StatefulWidget {
  const CreateSurveyQuestion({Key? key}) : super(key: key);

  @override
  State<CreateSurveyQuestion> createState() => _CreateSurveyQuestionState();
}

class _CreateSurveyQuestionState extends State<CreateSurveyQuestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Survey Questions', style: TextStyle(color: whiteColor), ),
        elevation: 0,
        backgroundColor: primaryColor,
      ),

      body: Padding(
        padding: defaultPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              SizedBox(
                height: 30,),
              //survey Duration


            ],

          ),
        ),
      ),


        floatingActionButton: FloatingActionButton.extended(
          onPressed:
              (){
            Navigator.push(context, MaterialPageRoute(builder:  (context) => MakePayments(),),);
          },
          label: Icon(Icons.save_rounded),
          backgroundColor: primaryColor,
        ),


    );
  }
}
