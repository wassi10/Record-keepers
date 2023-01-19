import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/screens/home_screen.dart';
import 'package:flutter_new/screens/splash_screen.dart';

void main() async{

 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();

    runApp(MyApp());
}
class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false, // for default banner remove

      theme: ThemeData(fontFamily: 'Poppins'),
      home: HomeScreen(),
        //SplashScreen(),

    );
  }
}
