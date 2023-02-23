import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/pages/participate_sure.dart';
import '../theme.dart';

class ParticipateScreen extends StatefulWidget {
  const ParticipateScreen({Key? key}) : super(key: key);
  @override
  State<ParticipateScreen> createState() => _ParticipateScreenState();
}

class _ParticipateScreenState extends State<ParticipateScreen> {
  @override
  Widget build(BuildContext context) {
    Query<Map<String, dynamic>> ref = FirebaseFirestore.instance
        .collection('survey')
        .orderBy('startDate',descending: true);
    final now = DateTime.now();
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
                      DocumentSnapshot data = streamSnapshot.data!.docs[index];
                      DateTime old = data['startDate'].toDate();
                      final diff = now.difference(old);
                       String time;

    if (diff.inDays >= 1) {
      time = '${diff.inDays} days ago';
    } else if (diff.inHours >= 1) {
      time = '${diff.inHours} hours ago';
    } else if (diff.inMinutes >= 1) {
      time = '${diff.inMinutes} minutes ago';
    } else {
      time = 'just now';
    }

                      // DateTime? dat = datt.toDate();

                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(data['image']),
                                ),

                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 12, left: 44),
                                  child: Wrap(children: [
                                    Text(
                                      data['name'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(" Created a Survey "),
                                      Text(time,  style: TextStyle(
                                  fontSize: 12,
                                ),)
                                   
                                  
                                    
                                  

                                  ]),
                                ),

                                // Text("${dat.day}-${dat.month}-${dat.year}"),
                              ],
                            ),
                            SizedBox(height: 10,),
                            MaterialButton(
                               shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                              minWidth: MediaQuery.of(context).size.width,
                              height: 80,
                              onPressed: () {},
                              child: Text(
                                "Tittle: ${data['title']}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                                
                                textAlign: TextAlign.justify,
                              ),
                              color: Colors.white70,
                            ),
                            SizedBox(height: 10),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Sureparticipate(data['unid'],data['endDate'].toDate().toString(),old.toString(),data['title'],data['details'],data['name'],data['url']),
                                  ),
                                );
                              },
                              
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 30,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(top: 5, left: 80),
                                    child: Text(
                                      "        Press to view details",
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: primaryColor)),
                            )
                          ],
                        ),
                      );
                    });
              } else {
                return Container();
              }
            }));
  }
}
