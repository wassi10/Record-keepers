import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class AboutUs extends StatefulWidget {

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text(
          'About App',
          style: TextStyle(color: whiteColor),
        ),
        elevation: 0,
        backgroundColor: primaryColor,
        ),
      body: Padding(
        
        padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
          
            children:  [
              SizedBox(
                height: 15,
              ),
              Text('This is an mobile app which is the collection of data possible in remote locations which can be very helpful for many researcher.\n',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),

              Text('This app have been developed by:',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500, color: secondaryColor),),

              SizedBox(height: 8,),

              //wassi
              ListView.builder(
                  itemCount: 1,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index ) =>Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                    child: Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 15.0),
                        color: primaryColor, // card color
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 130,
                                  height: 130,
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage('assets/wassi.png'),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget> [

                                    Text('Team Member 1 :\nKhadiza Akther\nID: 2012020295\nDepartment of CSE, \nLeading University',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500, color: Colors.white70),),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ),


              //proma
              ListView.builder(
                itemCount: 1,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index ) =>Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                  child: Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 15.0),
                      color: primaryColor, // card color
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 130,
                                height: 130,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage('assets/promaa.png'),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget> [

                                  Text('Team Member 2 :\nMoulia Das Proma\nID: 2012020029\nDepartment of CSE, \nLeading University',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500, color: Colors.white70),),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              //himu
              ListView.builder(
                itemCount: 1,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index ) =>Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                  child: Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 15.0),
                      color: primaryColor, // card color
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 130,
                                height: 130,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage('assets/himu.png'),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget> [

                                  Text('Team Member 3 :\nHumayra Kabir Nisa\nID: 2012020298\nDepartment of CSE, \nLeading University',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500, color: Colors.white70),),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),



            ],

          ),
        ),




    );
  }
}
