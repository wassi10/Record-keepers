import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/pages/participate_sure.dart';
import 'package:flutter_new/screens/homeSreen_.dart';
import '../theme.dart';

class Myparticipation extends StatefulWidget {
  const Myparticipation({Key? key}) : super(key: key);
  @override
  State<Myparticipation> createState() => _MyparticipationState();
}

class _MyparticipationState extends State<Myparticipation> {
  @override
  Widget build(BuildContext context) {
    CollectionReference ref = FirebaseFirestore.instance
        .collection('MyParticipations')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('random');

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Home',
            style: TextStyle(
                fontSize: 22, color: whiteColor, fontWeight: FontWeight.w700),
          ),
          elevation: 0,
          backgroundColor: primaryColor,
       // this is for remove the back button
        ),
        body: Padding(
          padding: defaultPadding,
          child: StreamBuilder(
              stream: ref.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                      itemCount: streamSnapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        String s1 = "";
                        DocumentSnapshot data = streamSnapshot.data!.docs[index];
                        return Padding(
                          
                          padding: defaultPadding,
                          
                          child:  Column(
                            children:[
                          
                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                                "Enter The unique key you've recieved after participating this survey!"),
                                            TextFormField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText: 'Unique key',
                                                contentPadding:
                                                    EdgeInsets.all(10),
                                              ),
                                              onChanged: (value) {
                                                s1 = value;
                                              },
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  //primary: Colors.purple,
                                                  backgroundColor: primaryColor,
                                                ),
                                                onPressed: () {
                                              FirebaseFirestore.instance.collection('Earnings')
                                                      .doc(FirebaseAuth.instance
                                                          .currentUser?.uid)
                                                      .collection('random')
                                                      .where('unid',
                                                          isEqualTo: data['unid'])
                                                      .get()
                                                      .then(
                                                          (QuerySnapshot value) {
                                                    if (value.docs.isNotEmpty) {
                                                             showDialog(
                                                        context: context,
                                                        builder:
                                                            (_) => AlertDialog(
                                                                  content: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                     
                                                                      Text(
                                                                          "You have already earned from this survey!!"),
                                                                      ElevatedButton(
                                                                          style: ElevatedButton
                                                                              .styleFrom(
                                                                            //primary: Colors.purple,
                                                                            backgroundColor:
                                                                                primaryColor,
                                                                          ),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator
                                                                                .push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                builder: (context) => HomeSreeen(),
                                                                              ),
                                                                            );
                                                                          },
                                                                          child: Text(
                                                                              "Okay"))
                                                                    ],
                                                                  ),
                                                                ));
                                                        }else{
                                                             if (data['unid'] == s1) {
                                                    CollectionReference ref =
                                                        FirebaseFirestore.instance
                                                            .collection(
                                                                'Earnings')
                                                            .doc(FirebaseAuth
                                                                .instance
                                                                .currentUser
                                                                ?.uid)
                                                            .collection('random');
                                                    var data = {
                                                      'unid': s1,
                                                    };
                                                    ref.add(data);

                                                    _uupdate(5);
                                                    showDialog(
                                                        context: context,
                                                        builder:
                                                            (_) => AlertDialog(
                                                                  content: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .check_circle,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                      Text(
                                                                          "You got 5 new coins!"),
                                                                      ElevatedButton(
                                                                          style: ElevatedButton
                                                                              .styleFrom(
                                                                            //primary: Colors.purple,
                                                                            backgroundColor:
                                                                                primaryColor,
                                                                          ),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator
                                                                                .push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                builder: (context) => HomeSreeen(),
                                                                              ),
                                                                            );
                                                                          },
                                                                          child: Text(
                                                                              "Continue"))
                                                                    ],
                                                                  ),
                                                                ));
                                                  } else {
                                                    showDialog(
                                                        context: context,
                                                        builder:
                                                            (_) => AlertDialog(
                                                                  content: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .dangerous,
                                                                        color: Colors
                                                                            .red,
                                                                      ),
                                                                      Text(
                                                                          "Wrong Key!"),
                                                                      ElevatedButton(
                                                                          style: ElevatedButton
                                                                              .styleFrom(
                                                                            //primary: Colors.purple,
                                                                            backgroundColor:
                                                                                primaryColor,
                                                                          ),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator
                                                                                .push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                builder: (context) => Myparticipation(),
                                                                              ),
                                                                            );
                                                                          },
                                                                          child: Text(
                                                                              "Done"))
                                                                    ],
                                                                  ),
                                                                ));
                                                  }




                                                           
                                                        }
                                                  });

                                               
                                                },
                                                child: Text("Confirm"))
                                          ],
                                        ),
                                      ));
                            },
                            
                            child: Container(
                              margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                height: 60,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    Text(
                                      "Title: ${data['title']}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                )),
                           ),
                           SizedBox(height: 10,), 
                           
                           ]

                          ),
                        );
                        SizedBox(
                          height: 10,
                        );
                      });
                } else {
                  return Container();
                }
              }),
        ));
  }

  Future<void> _uupdate(int co) async {
    CollectionReference ref = FirebaseFirestore.instance.collection('uinfo');

    await ref.doc(FirebaseAuth.instance.currentUser?.uid).update({"score": co});
  }
}
