import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/screens/_uploadPhoto.dart';
import 'package:flutter_new/screens/change_pass.dart';
import 'package:flutter_new/widgets/user.dart';

import '../theme.dart';
import 'about_app.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //for sign out
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    late User? user = auth.currentUser;
    late String? uid = user?.uid;
    CollectionReference reef = FirebaseFirestore.instance.collection('uinfo');
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: whiteColor),
        ),
        elevation: 0,
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false, // this is for remove the back button
      ),
      
      body: StreamBuilder(
          stream: reef.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                  itemCount: streamSnapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = streamSnapshot.data!.docs[index];
                    if (uid == data.id) {
                      return SingleChildScrollView(
                          child: Column(children: [
                        const SizedBox(
                          height: 20,
                        ),
                        data['img'] == null
                            ? Column(children: [
                                Stack(children: [
                                  const CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 95,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      radius: 90,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 175, left: 80),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Uploadphoto(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: const Icon(Icons.add)),
                                    ),
                                  ),
                                ]),
                                //SizedBox(height: 600,),
                                Text(
                                  data['name'],
                                  style: const TextStyle(
                                    fontFamily: 'poppins',
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                // SizedBox(height: 10,),
                                Text(
                                  data['email'],
                                  style: const TextStyle(
                                    fontFamily: 'poppins',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    //   color: Colors.grey,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ])
                            : Stack(children: [
                                CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  radius: 95,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    backgroundImage: NetworkImage(
                                      data['img'],
                                    ),
                                    radius: 90,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 175, left: 80),
                                  child: InkWell(
                                    onTap: (() {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Uploadphoto(),
                                        ),
                                      );
                                    }),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: const Icon(Icons.add)),
                                  ),
                                ),
                              ]),
                        // SizedBox(height: 600,),
                        Text(
                          data['name'],
                          style: const TextStyle(
                            fontFamily: 'poppins',
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        //SizedBox(height: 10,),
                        Text(
                          data['email'],
                          style: const TextStyle(
                            fontFamily: 'poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            // color: Colors.grey,
                          ),
                          textAlign: TextAlign.justify,
                        ),

                        const SizedBox(
                          height: 50,
                        ),
                        
                        //change password
                        MaterialButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ChangePassword(),
                              ),
                            );
                          },
                          child: const ListTile(
                            title: Text(
                              'Change Password',
                              style: TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 20,
                                  color: blackColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),

                        //about app
                        MaterialButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUs(),),);
                          },
                          child: const ListTile(
                            title: Text(
                              'About app',
                              style: TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 20,
                                  color: blackColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),

                        //logout button
                        MaterialButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(),),);
                          },
                          child: const ListTile(
                            leading: Icon(Icons.arrow_back),
                            title: Text(
                              'Log Out',
                              style: TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 18,
                                  color: blackColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ]));
                    } else {
                      return Container(
                        height: 0,
                        width: 0,
                      );
                    }
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
