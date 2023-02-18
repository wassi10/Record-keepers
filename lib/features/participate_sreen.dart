import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../theme.dart';
class ParticipateScreen extends StatefulWidget {
const ParticipateScreen({Key? key}) : super(key: key);
  @override
  State<ParticipateScreen> createState() => _ParticipateScreenState();
}

class _ParticipateScreenState extends State<ParticipateScreen> {
  @override
  Widget build(BuildContext context) {
    CollectionReference ref = FirebaseFirestore.instance
        .collection('surveyInfo')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('information');
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Home',
            style: TextStyle(
                fontSize: 22, color: whiteColor, fontWeight: FontWeight.w700),
          ),
          elevation: 0,
          backgroundColor: primaryColor,
          automaticallyImplyLeading:
              false, // this is for remove the back button
        ),
        body: StreamBuilder(
            stream: ref.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView.builder(
                    itemCount: streamSnapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot data =
                          streamSnapshot.data!.docs[index];
                      Timestamp datt = data['startDate'];
                      DateTime? dat = datt.toDate();

                      return Column(
                        children: [
                          Wrap(
                            children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(data['image']),
                            ),
                            Text(data['name']),
                            Text(" Created a Survey"
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            
                          
                          ]
                          ),
                          Text("${dat.day}-${dat.month}-${dat.year}"),
                          SizedBox(height:30),

                        ],
                      );
                    });
              } else {
                return Container();
              }
            }));
  }
}
