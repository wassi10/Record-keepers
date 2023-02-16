import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/screens/homeSreen_.dart';
import 'package:flutter_new/screens/splash_screen.dart';
import 'package:flutter_new/widgets/user.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async{
 WidgetsFlutterBinding.ensureInitialized();
 Stripe.publishableKey = "pk_test_51MSg5oIk9gUHQ0ToysHViMcc1ZbHL0RpERAjqxFjxfzzAsz3GWH8sPVUzJYMKjPNbCI8T5RszmAdiKYsKT1lsMTO00tzejYmx1";
 await Firebase.initializeApp();
    runApp(MyApp());
}
class MyApp extends StatelessWidget { 
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false, // for default banner remove

      theme: ThemeData(fontFamily: 'Poppins'),
      home: SplashScreen(),
        //SplashScreen(),
      //HomeSreeen(),

    );
  }
}


