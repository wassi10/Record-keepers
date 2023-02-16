import 'package:flutter/material.dart';
import '../features/participate_sreen.dart';
import '../theme.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateSurveyQuestion extends StatefulWidget {
  CreateSurveyQuestion(this.number, {Key? key}) : super(key: key);
  dynamic number;

  @override
  State<CreateSurveyQuestion> createState() => _CreateSurveyQuestionState();
}

class _CreateSurveyQuestionState extends State<CreateSurveyQuestion> {
  int dataToChange = 1; // for increasing value
  void changeData() {
    setState(() {
      dataToChange += 1;
    });
  }

  void removeData() {
    setState(() {
      dataToChange -= 1;
    });
  }

  bool _isExpanded = false;
  Map<String, dynamic>? paymentIntent;

  bool isStrechedDropDown = false;
  // //we can add more question
  List<TextEditingController> listController = [TextEditingController()];

  @override
  Widget build(BuildContext context) {
    final String SECRET_KEY =
        "sk_test_51MSg5oIk9gUHQ0TofSMoSHqZgspvFDDxdJpu4MxLGEDo2vG5Vqafm3LCq1UQgwgrC4OSXM8gR2sk9pBe5aHDPR2P00tyQbfuqu";
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Survey Questions',
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
                height: 30,
              ),
              //survey Duration

              Text("Total  $dataToChange Questions",
                  style: const TextStyle(
                      fontSize: 22,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w600,
                      color: blackColor)),

              const SizedBox(
                height: 20,
              ),

              //add button
              FloatingActionButton.small(
                onPressed: () {
                  changeData();
                  setState(() {
                    listController.add(TextEditingController());
                  });
                },
                child: const Icon(Icons.add),
                backgroundColor: primaryColor,
              ),

              const SizedBox(
                height: 30,
              ),

              Container(
                color: primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        '  Question 1',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w500,
                            color: whiteColor),
                      ),
                    ),
                    ExpandIcon(
                      isExpanded: _isExpanded,
                      expandedColor: whiteColor,
                      onPressed: (bool isExpanded) {
                        setState(() {
                          _isExpanded = !isExpanded;
                        });
                      },
                    ),
                  ],
                ),
              ),
              if (_isExpanded)
                const Padding(
                  padding: defaultPadding,
                  child: Text(
                    "Question",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w500,
                        color: blackColor),
                  ),
                ),


            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await makePayment();
        },
        label: const Text(
          "Payment",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        backgroundColor: primaryColor,
      ),
    );
  }

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
                                          Navigator.push(context, MaterialPageRoute(builder:  (context) =>  ParticipateScreen(),),);
                               
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
