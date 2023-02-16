import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    late User? user = auth.currentUser;
    late String? uid = user?.uid;
    Query<Map<String, dynamic>> reef =
        FirebaseFirestore.instance.collection('uinfo');

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Wallet',
            style: TextStyle(fontSize: 22 ,color: whiteColor, fontWeight: FontWeight.w700),
          ),
          elevation: 0,
          backgroundColor: primaryColor,
          automaticallyImplyLeading:
              false, // this is for remove the back button
        ),
        body: StreamBuilder(
            stream: reef.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView.builder(
                    itemCount: streamSnapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot data = streamSnapshot.data!.docs[index];
                      if (data.id == uid) {
                        return  Padding(
        padding: defaultPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [

              const SizedBox(
                height: 100,
              ),

              Container(
                width: MediaQuery.of(context).size.width,
                height: 180,
                alignment: Alignment.center,

                decoration: BoxDecoration( color: primaryColor,borderRadius: BorderRadius.circular(25),),

                child: Column(
                  children:  [
                    SizedBox(
                      height: 30,
                    ),
                    Text('Balance',
                      style: TextStyle(color: Colors.white70, fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("\$ ${data['score']}",
                    
                      style: TextStyle(color: whiteColor, fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],

          ),

        ),
      );

                        
                        
                        

                        
                      } else {
                        return Container();
                      }
                    });
              } else {
                return Text("No users");
              }
            }));
  }
}
