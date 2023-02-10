import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../theme.dart';
import '_updateNote.dart';

class viewNote extends StatefulWidget {
  viewNote(this.docc, this.tit, this.des, this.dat, {super.key});
  //QueryDocumentSnapshot doc;
  late String des;
  late String tit;
  dynamic docc;
  DocumentSnapshot dat;
  @override
  State<viewNote> createState() => _viewNoteState();
}

class _viewNoteState extends State<viewNote> {
  //CollectionReference ref = FirebaseFirestore.instance.collection('notes').doc(FirebaseAuth.instance.currentUser?.uid).collection('notess');
  TextEditingController tittle = TextEditingController();
  TextEditingController dis = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white70,
      //  backgroundColor: primaryColor,
      appBar: AppBar(
        bottomOpacity: 0.1,
        backgroundColor: primaryColor,
        actions: [
          Theme(
            data: Theme.of(context).copyWith(
              cardColor: Colors.white,
            ),
            child: PopupMenuButton<int>(
                onSelected: (value) => Onselected(context, value),
                icon: const Icon(Icons.more_vert, color: Colors.white),
                itemBuilder: ((context) => [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Row(
                      children: const [
                        Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text("Edit",
                              style: TextStyle(
                                // color: Colors.white,
                              )),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 1,
                    child: Row(children: const [
                      Icon(
                        Icons.delete,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          "Delete",
                          style: TextStyle(

                          ),
                        ),
                      ),
                    ]),
                  ),
                ])),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
              alignment: Alignment.topCenter,
              child: Text(
                widget.tit,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.des,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'poppins',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _delete(String dataId) async {
    CollectionReference ref = FirebaseFirestore.instance
        .collection('notes')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('notess');
    await ref.doc(dataId).delete();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Deleted"),
      backgroundColor: primaryColor,
    ));
    Navigator.pop(context);
  }



  void Onselected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.push(
            context,

            MaterialPageRoute(
                builder: (context) =>
                    UpdateNotes(widget.docc, widget.tit, widget.des)

            ));
        break;
      case 1:
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content:
            const Text('This action will permanently delete this data'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: primaryColor,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  _delete(widget.docc);
                  Navigator.pop(context);
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
        );

        break;
    }
  }
}