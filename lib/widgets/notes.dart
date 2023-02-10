import 'dart:core';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_new/theme.dart';
import 'package:flutter_new/widgets/_updateNote.dart';
import 'package:flutter_new/widgets/add_notes.dart';
import 'package:flutter_new/widgets/view_note.dart';
import 'package:intl/intl.dart';

//khadizawassi@gmail.com

class Notes extends StatefulWidget {
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  CollectionReference ref = FirebaseFirestore.instance
      .collection('notes')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('notess');

  List<Color> myColors = [
    Colors.lightGreen,
    Colors.cyan,
    Colors.pinkAccent,
    Colors.deepPurple,
    Colors.brown,
    Colors.limeAccent
  ];

  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(
          'Notes',
          style: TextStyle(color: whiteColor),
        ),
        elevation: 0,
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false, // this is for remove the back button
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNotes(),
            ),
          ).then((value) {
            print("Colling Set State !");
            setState(() {});
          });
        },
        label: Icon(Icons.add),
        backgroundColor: primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      body: StreamBuilder(
        stream: ref.snapshots(),
        //  future: ref.get(),
        builder: (context, AsyncSnapshot<QuerySnapshot>streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (streamSnapshot.hasData) {
            return ListView.builder(
                itemCount:streamSnapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  Random random = new Random();
                  Color backgroundColor = myColors[random.nextInt(6)];

                  // Object? data = snapshot.data?.docs[index].data();

                  //Map data = snapshot.data!.docs[index].data() as Map;
                  DocumentSnapshot data =
                  streamSnapshot.data!.docs[index];

                  DateTime mydateTime = data['created'].toDate();
                  String formattedTime =
                  DateFormat.yMMMd().add_jm().format(mydateTime);

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,

                          MaterialPageRoute(
                            builder: (context) => viewNote(
                              data.id,
                              data["tittle"],
                              data["description"],
                              data,
                            ),


                            //dynamic up = new viewNote();
                            // up._update(data);
                          ));
                    },
                    child: Card(
                      color: backgroundColor,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data["tittle"],
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 20.0,
                                fontFamily: 'poppins',
                              ),
                            ),

                            // date show
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                formattedTime,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'poppins',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }else {
            return Center(
              child: Text("Add Notes"),
            );
          }
        },
      ),
    );
  }

}