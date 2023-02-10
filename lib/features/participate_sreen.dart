import 'package:flutter/material.dart';

import '../theme.dart';

class ParticipateScreen extends StatefulWidget {
  const ParticipateScreen({Key? key}) : super(key: key);

  @override
  State<ParticipateScreen> createState() => _ParticipateScreenState();
}

class _ParticipateScreenState extends State<ParticipateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Home', style: TextStyle(color: whiteColor), ),
        elevation: 0,
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false, // this is for remove the back button
      ),

      body: Center(
        child: Column(
          children: const [
            SizedBox(height: 200,),
            Text("participate screen"),
          ],
        ),
      ),
    );
  }
}
