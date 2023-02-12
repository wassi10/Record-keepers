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
    return Scaffold(

      appBar: AppBar(
        title: const Text('Wallet', style: TextStyle(color: whiteColor), ),
        elevation: 0,
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false, // this is for remove the back button
      ),

      body: Padding(
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
                  children: const [
                    SizedBox(
                      height: 30,
                    ),
                    Text('Balance',
                      style: TextStyle(color: Colors.white70, fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("\$ 1000.00",
                      style: TextStyle(color: whiteColor, fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],

          ),

        ),
      ),
    );
  }
}

// children: const [
//
// SizedBox(
// height: 80,
// ),
// Text('Balance',
// style: TextStyle(color: secondaryColor, fontSize: 20),
// ),
// SizedBox(
// height: 20,
// ),
// Text("\$ 1000.00",
// style: TextStyle(color: blackColor, fontSize: 30, fontWeight: FontWeight.bold),
// ),
// ],