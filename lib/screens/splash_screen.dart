//first page
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/theme.dart';
import 'package:flutter_new/screens/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {

  void initState(){
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LogInScreen(),),);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primaryColor,

        child: Center(
          child: Text(
            'Record Keepers', style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: whiteColor
          ),
          ),

        ),
      ),
    );
  }

}