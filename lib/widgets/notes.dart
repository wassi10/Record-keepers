import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_new/theme.dart';
import 'package:flutter_new/widgets/add_notes.dart';

//khadizawassi@gmail.com

class Notes extends StatefulWidget {


  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {


  CollectionReference ref = FirebaseFirestore.instance.collection('notes').doc(FirebaseAuth.instance.currentUser?.uid).collection('Notes');

  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Notes', style: TextStyle(color: whiteColor), ),
        elevation: 0,
        backgroundColor: primaryColor,
      ),


      floatingActionButton: FloatingActionButton.extended(
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotes()),);
      },

      label: Icon(Icons.add),
      backgroundColor: primaryColor,
    ),


      body: FutureBuilder<QuerySnapshot>(
        future: ref.get(),
        builder: (context, snapshot){

          if(snapshot.hasData){

            return ListView.builder(

                itemCount: snapshot.data!.docs.length,

                itemBuilder: (context, index){


                  // Object? data = snapshot.data!.docs[index].data();
                 Map? data = snapshot.data?.docs[index].data() as Map;

              return Card(
                child: Padding(
                  padding:  const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      "${data['title']}",
                      style: TextStyle(
                        fontSize: 18.0, fontFamily: 'poppins',
                      ),
                    ),
                  ],
                ),
                ),
              );
            });
          }else{

            return Center(
              // child: Text("Loading..."),
            );
          }
       },),


    );
  }
}
