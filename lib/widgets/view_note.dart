
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/theme.dart';

class ViewNote extends StatefulWidget {

  // final Map data;
  // final String time;
  // final DocumentReference ref;
  // ViewNote(this.data, this.time, this.ref);

  @override
  State<ViewNote> createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {

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

                Column(

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


                          maxLines: 20,
                        ),
                      ),




                      Container(
                        height: MediaQuery.of(context).size.height * 0.80,
                        padding: EdgeInsets.only(top: 0),

                        //description textformfield
                        child: TextFormField(
                          decoration: InputDecoration.collapsed(hintText:"Description",),
                          style: TextStyle(
                            fontSize: 18.0, fontFamily: 'poppins',
                          ),


                          maxLines: 25,
                        ),
                      ),


                    ],
                  ),

              ],
            ),
          ),

        ),),



      floatingActionButton: FloatingActionButton.extended(
        onPressed: add,

        label: Icon(Icons.delete_forever),
        backgroundColor: Colors.red[700],
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
