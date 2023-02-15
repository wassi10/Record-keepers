import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/theme.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late User? user = auth.currentUser;
  late String? uid = user?.uid;

  @override
  Widget build(BuildContext context) {
    final moodStream = FirebaseFirestore.instance
        .collection('uinfo')
        .orderBy('score', descending: true)
        .snapshots();
    final activityStream = FirebaseFirestore.instance
        .collection('uinfo')
        .orderBy('score', descending: true)
        .snapshots();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(
            "Profile",
            style: TextStyle(fontSize: 20),
          ),
          // centerTitle: true,
          elevation: 0.0,
          automaticallyImplyLeading:
              false, // this is for remove the back button
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: moodStream,
            builder: (context, moodStream) {
              if (moodStream.hasData) {
                return ListView.builder(
                    itemCount: moodStream.data?.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot data = moodStream.data!.docs[index];
                      return data.id == uid
                          ? SingleChildScrollView(
                              child: Column(
                                children: [
                                  //SizedBox(height: 40,),

                                  Container(
                                    padding: const EdgeInsets.only(top: 40),
                                    height: 330,
                                    decoration: const BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(20),
                                            bottomLeft: Radius.circular(20))),
                                    child: Column(
                                      children: [
                                        Stack(
                                          children: [
                                             CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  data['img'],),
                                                   radius: 50,
                                             
                                            ),
                                            Positioned(
                                              bottom: 0.0,
                                              right: 0.0,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white),
                                                child: const Icon(
                                                  Icons.edit,
                                                  color: Colors.blueAccent,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                         Text(
                                            data['name'],
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Divider(
                                          thickness: 1,
                                          indent: 20,
                                          endIndent: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            // Column(
                                            //   children: [
                                            //     // Text(
                                            //     //   "45",
                                            //     //   style: TextStyle(
                                            //     //       fontSize: 42,
                                            //     //       fontWeight: FontWeight.w300,
                                            //     //       color: Colors.white.withOpacity(0.9)),
                                            //     // ),
                                            //     const Text("Level",
                                            //         style: TextStyle(
                                            //             fontSize: 25,
                                            //             fontWeight: FontWeight.bold,
                                            //             color: Colors.white)),
                                            //   ],
                                            // ),
                                            Column(
                                              children: [
                                                Text("#${index+1}",
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: Colors.white
                                                            .withOpacity(0.9))),
                                                const Text("Rank",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white)),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    "Leader Board",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),

                                  StreamBuilder<QuerySnapshot>(
                                      stream: activityStream,
                                      builder: (context, activityStream) {
                                        if (activityStream.hasData) {
                                          return Container(
                                            margin: const EdgeInsets.all(20),
                                            child: SizedBox(
                                              height: 200,
                                              child: ListView.separated(
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) {
                                                         DocumentSnapshot daata = activityStream.data!.docs[index];
                                                    return ListTile(
                                                      title: Row(
                                                        children: [
                                                          CircleAvatar(
                                                            backgroundImage:
                                                                NetworkImage(
                                                                   daata['img']),
                                                          ),
                                                          SizedBox(
                                                            width: 4,
                                                          ),
                                                          Text(daata['name']),
                                                        ],
                                                      ),
                                                      leading: Text(
                                                        "#${index + 1}",
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      trailing: Text(
                                                        "${daata['score']}",
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (context, index) =>
                                                          const Divider(
                                                            thickness: 1,
                                                            color: Colors.blue,
                                                            indent: 10,
                                                            endIndent: 10,
                                                          ),
                                                  itemCount: activityStream.data!.docs.length),
                                            ),
                                          );
                                        } else {
                                          return Container();
                                        }
                                      })
                                ],
                              ),
                            )
                          : Container();
                    });
              } else {
                return Container();
              }
            }));
  }
}
