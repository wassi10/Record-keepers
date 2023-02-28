import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/screens/homeSreen_.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

import '../theme.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

String s1 = "";


class _WalletState extends State<Wallet> {
  Map<String, dynamic>? paymentIntent;
  @override
  Widget build(BuildContext context) {
    
    Query<Map<String, dynamic>> reef =
        FirebaseFirestore.instance.collection('uinfo');
        final String SECRET_KEY =
        "sk_test_51MSg5oIk9gUHQ0TofSMoSHqZgspvFDDxdJpu4MxLGEDo2vG5Vqafm3LCq1UQgwgrC4OSXM8gR2sk9pBe5aHDPR2P00tyQbfuqu";

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Wallet',
            style: TextStyle(
                fontSize: 22, color: whiteColor, fontWeight: FontWeight.w700),
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
                      final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
   String? uid = user?.uid;
                      DocumentSnapshot data = streamSnapshot.data!.docs[index];
                      if (data.id == uid) {
                        return Padding(
                          padding: defaultPadding,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 100,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 180,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Text(
                                        'Coins',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "\$ ${data['score']}",
                                        style: TextStyle(
                                            color: whiteColor,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                              
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                      "Enter number of coins you want to buy"),
                                                  TextFormField(
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText: 'Enter number of coins',
                                                      contentPadding:
                                                          EdgeInsets.all(10),
                                                    ),
                                                    onChanged: (value) {
                                                      s1 = value;
                                                    },
                                                  ),
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        //primary: Colors.purple,
                                                        backgroundColor:
                                                            primaryColor,
                                                      ),
                                                      onPressed: () {
                                                        makePayment();
                                                      },
                                                      child: Text("Buy"))
                                                ],
                                              ),
                                            ));
                                  },
                                  child:  Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 80,
                                 
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Buy Coins',
                                       style: TextStyle(
                                            color: whiteColor,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    
                                    
                                        
                                      
                                    ],
                                  ),
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

  Future<void> makePayment() async {
    try {
      paymentIntent =
          await createPaymentIntent(s1.toString(), "USD");
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!['client_secret'],
              style: ThemeMode.dark,
              merchantDisplayName: "Record Keepers"));

      displayPaymentSheet();
    } catch (error, s) {
      print("Exception found ${error.toString()}");
    }
  }

  createPaymentIntent(String amount, String currency) async {
    final String SECRET_KEY =
        "sk_test_51MSg5oIk9gUHQ0TofSMoSHqZgspvFDDxdJpu4MxLGEDo2vG5Vqafm3LCq1UQgwgrC4OSXM8gR2sk9pBe5aHDPR2P00tyQbfuqu";
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $SECRET_KEY',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );

      print(response.body);
      return jsonDecode(response.body);
    } catch (error) {
      print("Error Charging the user ${error.toString()}");
    }
  }

  calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;
    return calculatedAmount.toString();
  }

  displayPaymentSheet() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
   String? uid = user?.uid;
      DocumentReference docRef = FirebaseFirestore.instance.collection('uinfo').doc(uid);
          DocumentSnapshot docSnapshot = await docRef.get();

          //  Object? data = docSnapshot.data();
          // Do something with the data

          int co = docSnapshot['score'];
    try {
      await Stripe.instance.presentPaymentSheet().then((value) => {

                 _uupdate(co+(int.parse(s1))),

            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.grey,
                          ),
                          
                           

                          Text("You got ${s1} new coins!"),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                //primary: Colors.purple,
                                backgroundColor: primaryColor,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeSreeen(),
                                  ),
                                );
                              },
                              child: Text("Done"))
                        ],
                      ),
                    ))
          });

      paymentIntent = null;
    } on StripeException catch (error) {
      print("Error $error");
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text("Cancelled"),
              ));
    }
  }
  Future<void> _uupdate(int co) async {
   CollectionReference ref =
        FirebaseFirestore.instance.collection('uinfo');

    await ref
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update({"score": co });
  }

}
