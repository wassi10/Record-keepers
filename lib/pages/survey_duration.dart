import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_new/screens/homeSreen_.dart';
import 'package:flutter_new/screens/login.dart';
import 'package:flutter_new/theme.dart';
import 'dart:core';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../features/participate_sreen.dart';

class SurveyDuration extends StatefulWidget {
  SurveyDuration(this.number, this.title, this.details, {Key? key})
      : super(key: key);
  dynamic number, title, details;
  @override
  State<SurveyDuration> createState() => _SurveyDurationState();
}

class _SurveyDurationState extends State<SurveyDuration> {
  late String chooseCategory = "-1";
  DateTime? startDate = DateTime.now() ;
  DateTime? endDate;
  late String url;
  Map<String, dynamic>? paymentIntent;

  // defined category

  @override
  Widget build(BuildContext context) {
    final String SECRET_KEY =
        "sk_test_51MSg5oIk9gUHQ0TofSMoSHqZgspvFDDxdJpu4MxLGEDo2vG5Vqafm3LCq1UQgwgrC4OSXM8gR2sk9pBe5aHDPR2P00tyQbfuqu";
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Survey Duration',
          style: TextStyle(color: whiteColor),
        ),
        elevation: 0,
        backgroundColor: primaryColor,
      ),

      body: Padding(
        padding: defaultPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),

              //survey Duration
              const Text('Survey Duration',
                  style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w600,
                      color: blackColor)),

              const SizedBox(
                height: 15,
              ),

              const Text('Start and End ',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w400,
                      color: secondaryColor)),

              const SizedBox(
                height: 5,
              ),

              // start date

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  
                ],
              ),
              const SizedBox(
                height: 10,
              ),

              // end date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                      ),
                      onPressed: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2010),
                          lastDate: DateTime(2025),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: primaryColor, // <-- SEE HERE
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (pickedDate != null) {
                          setState(() {
                            endDate = pickedDate;
                          });
                        }
                      },
                      child: Text(
                        endDate == null
                            ? 'End Date'
                            : '${endDate!.day}-${endDate!.month}-${endDate!.year}',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'poppins',
                            color: whiteColor),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 55,
              ),

              const Text(
                  'Upload any form url where your Survey questions are added:',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w600,
                      color: blackColor)),

              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: "Paste url...",
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(10),
                ),
                onChanged: (_val) {
                  url = _val;
                },
              ),

              /*Card(
                color: Colors.white54,
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  value: chooseCategory,
                  items: const [
                    DropdownMenuItem(
                      child: Text("  Select Category"),
                      value: "-1",
                    ),
                    DropdownMenuItem(
                      child: Text("  Blockchain"),
                      value: "1",
                    ),
                    DropdownMenuItem(
                      child: Text("  Entertainment"),
                      value: "2",
                    ),
                    DropdownMenuItem(
                      child: Text("  Health"),
                      value: "3",
                    ),
                    DropdownMenuItem(
                      child: Text("  Politics"),
                      value: "4",
                    ),
                    DropdownMenuItem(
                      child: Text("  Economy"),
                      value: "5",
                    ),
                    DropdownMenuItem(
                      child: Text("  Religion"),
                      value: "6",
                    ),
                    DropdownMenuItem(
                      child: Text("  Business"),
                      value: "7",
                    ),
                    DropdownMenuItem(
                      child: Text("  Education"),
                      value: "8",
                    ),
                    DropdownMenuItem(
                      child: Text("  Society"),
                      value: "9",
                    ),
                  ],
                  onChanged: (v) {},
                ),
              ), */
            ],
          ),
        ),
      ),

      //next button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          makePayment();
        },
        label: const Text(
          "Next",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        backgroundColor: primaryColor,
      ),
    );
  }

  // void add() async {
  //   //save to firestore
  //   CollectionReference ref = FirebaseFirestore.instance.collection(
  //       'surveyInfo').doc(FirebaseAuth.instance.currentUser?.uid).collection(
  //       'information');
  //
  //   var data = {
  //     'Category': chooseCategory,
  //     'startDate': startDate,
  //     'endDate': endDate,
  //   };
  //   ref.add(data);
  //
  //   Navigator.push(context, MaterialPageRoute(
  //     builder: (context) => CreateSurveyQuestion(),),);
  // }
  // selected;

  Future<void> makePayment() async {
    try {
      paymentIntent =
          await createPaymentIntent(widget.number.toString(), "USD");
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
    try {
      CollectionReference ref = FirebaseFirestore.instance
          .collection('surveyInfo')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('information');
      var data = {
        'name': nam,
        'image': img,
        'startDate': startDate,
        'endDate': endDate,
        'title': widget.title,
        'details': widget.details,
        'number': widget.number,
        'url':url,
      };
      ref.add(data);

      await Stripe.instance.presentPaymentSheet().then((value) => {
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
                          Text("Payment Successful"),
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
}
