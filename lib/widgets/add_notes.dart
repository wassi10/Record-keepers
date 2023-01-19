
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/theme.dart';

class AddNotes extends StatefulWidget {

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  
  late String title;
  late String description;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
    backgroundColor: primaryColor,
      ),


   body: Padding(
     padding: EdgeInsets.all(18.0),

     child: SingleChildScrollView(

       child: Container(


         child: Column(
       
           children: [
             
             Form(
           child: Column(

           children: [

             SizedBox(height: 23,),

             //title textformfield
             TextFormField(
               decoration: InputDecoration.collapsed(hintText:" Tittle",),
               style: TextStyle(
                 fontSize: 24.0, fontFamily: 'poppins', fontWeight: FontWeight.bold,
               ),
               
               onChanged: (_val){
                 
                 title = _val;
               },
             ),

             //description textformfield
             TextFormField(
               decoration: InputDecoration.collapsed(hintText:"Note Description",),
               style: TextStyle(
                 fontSize: 20.0, fontFamily: 'poppins',
               ),

               onChanged: (_val){

                 description  = _val;
               },
             ),

           ],
         ),
         ),
         ],
     ),
       ),

   ),),



      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){

        },

        label: Icon(Icons.save_rounded),
        backgroundColor: primaryColor,
      ),

    );
  }
}
