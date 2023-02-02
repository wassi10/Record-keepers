import 'package:flutter/material.dart';

import '../theme.dart';

class MakePayments extends StatefulWidget {
  const MakePayments({Key? key}) : super(key: key);

  @override
  State<MakePayments> createState() => _MakePaymentsState();
}

class _MakePaymentsState extends State<MakePayments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Make a Payments', style: TextStyle(color: whiteColor), ),
        elevation: 0,
        backgroundColor: primaryColor,
      ),

    );
  }
}
