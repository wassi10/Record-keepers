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



      body: Center(
        child: Column(
          children: [
            SizedBox(height: 200,),
            Text("participate screen"),
          ],
        ),
      ),
    );
  }
}
