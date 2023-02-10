import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_new/theme.dart';

class UpdateNotes extends StatefulWidget {
  UpdateNotes(this.docc, this.tit, this.des, {super.key});
  late String des;
  late String tit;
  dynamic docc;
  @override
  State<UpdateNotes> createState() => _UpdateNotesState();
}

class _UpdateNotesState extends State<UpdateNotes> {
  // late String tittle;
  // late String discription;
  TextEditingController tittle = TextEditingController();
  TextEditingController discription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    tittle.text = widget.tit;
    discription.text = widget.des;
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
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        padding: EdgeInsets.only(top: 0),

                        //title textformfield
                        child: TextFormField(
                          controller: tittle,
                          decoration: InputDecoration.collapsed(
                            hintText: "Tittle",
                          ),
                          style: TextStyle(
                            fontSize: 24.0,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.bold,
                          ),

                          maxLines: 20,
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        padding: EdgeInsets.only(top: 0),

                        //description textformfield
                        child: SingleChildScrollView(
                          child: TextFormField(
                            controller: discription,
                            decoration: InputDecoration.collapsed(
                              hintText: "Description",
                            ),
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'poppins',
                            ),

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
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (() async {
          _update(widget.docc, widget.tit, widget.des);
        }),
        label: Icon(Icons.save_rounded),
        backgroundColor: primaryColor,
      ),
    );
  }

  Future<void> _update(String dataID, String oldtit, String olddis) async {
    final String titt = tittle.text;
    final String diss = discription.text;
    CollectionReference ref = FirebaseFirestore.instance
        .collection('notes')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('notess');
    await ref
        .doc(dataID)
        .update({"tittle": titt, "description": diss});
    tittle.text = '';
    discription.text = '';
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Updated"),
      backgroundColor: primaryColor,
    ));
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }
}