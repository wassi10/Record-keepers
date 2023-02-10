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

      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Text("wallet"),
          ],
        ),
      ),

    );
  }
}
