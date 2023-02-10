import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/theme.dart';

class AddNotes extends StatefulWidget {

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {

  late String title;
  late String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
      ),


      body: Padding(
        padding: EdgeInsets.all(18.0),

        child: SingleChildScrollView(

          child: Container(


            child: Column(

              children: [

                Form(
                  child: Column(

                    children: [

                      SizedBox(height: 20,),


                      Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        padding: EdgeInsets.only(top: 0),

                        //title textformfield
                        child: TextFormField(
                          decoration: InputDecoration.collapsed(hintText:"Tittle",),
                          style: TextStyle(
                            fontSize: 24.0, fontFamily: 'poppins', fontWeight: FontWeight.bold,
                          ),

                          onChanged: (_val){

                            title = _val;
                          },
                          maxLines: 20,
                        ),
                      ),

                      Container(
                        height: MediaQuery.of(context).size.height,
                        padding: EdgeInsets.only(top: 0),

                        //description textformfield
                        child: SingleChildScrollView(
                          child: TextFormField(
                            decoration: InputDecoration.collapsed(hintText:"Description",),
                            style: TextStyle(
                              fontSize: 18.0, fontFamily: 'poppins',
                            ),

                            onChanged: (_val){

                              description  = _val;
                            },
                            maxLines: 25,
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
              ],
            ),
          ),

        ),),



      floatingActionButton: FloatingActionButton.extended(
        onPressed: add,

        label: Icon(Icons.save_rounded),
        backgroundColor: primaryColor,
      ),

    );

  }
  void add() async{
    //save to firestore
    CollectionReference ref = FirebaseFirestore.instance.collection('notes').doc(FirebaseAuth.instance.currentUser?.uid).collection('notess');
    var data = {
      'tittle' : title,
      'description' : description,
      'created' : DateTime.now(),
    };
    ref.add(data);
    Navigator.pop(context);
  }
}