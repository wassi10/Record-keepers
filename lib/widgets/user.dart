import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/screens/login.dart';
import '../screens/homeSreen_.dart';

class MainPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return HomeSreeen();
          }
          else{
            return LogInScreen();
          }
        },
      ),
    );
  }
}
