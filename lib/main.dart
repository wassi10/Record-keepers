import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/screens/homeSreen_.dart';

import 'package:flutter_new/widgets/user.dart';

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
      home: MainPage(),
        //SplashScreen(),
      //HomeSreeen(),

    );
  }
}


