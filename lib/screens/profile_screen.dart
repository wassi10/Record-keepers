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
                                    radius: 80,
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
                                  backgroundColor: primaryColor,
                                  radius: 85,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    backgroundImage: NetworkImage(
                                      data['img'],
                                    ),
                                    radius: 80,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 155, left: 75),
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
                        Padding(
                          padding: defaultPadding,
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ChangePassword(),
                                ),
                              );
                            },
                            padding: EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),),
                            color: Colors.white70,
                            child: Row(
                              children: const [
                                Icon(Icons.lock_open, color: primaryColor,),
                                SizedBox(width: 20,),
                                Expanded(child: Text('Change Password',style: TextStyle(
                                    fontFamily: 'poppins',
                                    fontSize: 18,
                                    color: blackColor,
                                    fontWeight: FontWeight.w500),),),
                                Icon(Icons.arrow_forward_ios, color: primaryColor,),
                              ],
                            ),
                          ),
                        ),

                            SizedBox(
                              height: 10,
                            ),

                            //about app
                            Padding(
                              padding: defaultPadding,
                              child: MaterialButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUs(),),);
                                },
                                padding: EdgeInsets.all(15),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),),
                                color: Colors.white70,
                                child: Row(
                                  children: const [
                                    Icon(Icons.account_box_outlined, color: primaryColor,),
                                    SizedBox(width: 20,),
                                    Expanded(child: Text('About App',style: TextStyle(
                                        fontFamily: 'poppins',
                                        fontSize: 18,
                                        color: blackColor,
                                        fontWeight: FontWeight.w500),),),
                                    Icon(Icons.arrow_forward_ios, color: primaryColor,),
                                  ],
                                ),
                              ),
                            ),

                        SizedBox(
                          height: 10,
                        ),

                        //logout button
                       Padding(
                         padding: defaultPadding,

                         child:MaterialButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(),),);
                          },
                           padding: EdgeInsets.all(15),
                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),),
                           color: Colors.white70,
                          child: Row(
                            children: const [
                              Icon(Icons.logout, color: primaryColor,),
                              SizedBox(width: 20,),
                              Expanded(child: Text('Logout',style: TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 18,
                                  color: blackColor,
                                  fontWeight: FontWeight.w500),),),
                              Icon(Icons.arrow_forward_ios, color: primaryColor,),
                            ],
                          )

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
