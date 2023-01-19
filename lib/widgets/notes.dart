import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_new/theme.dart';
import 'package:flutter_new/widgets/add_notes.dart';

//khadizawassi@gmail.com

class Notes extends StatefulWidget {

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Notes', style: TextStyle(color: whiteColor), ),
        elevation: 0,
        backgroundColor: primaryColor,
      ),

      body: Padding(

          padding: defaultPadding,

        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
                'Recent Notes', style: TextStyle(fontSize: 22.0, fontFamily: 'poppins', fontWeight: FontWeight.bold,),
            ),
          ],
        ),
        
      ),



    floatingActionButton: FloatingActionButton.extended(
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotes()),);
      },

      label: Icon(Icons.add),
      backgroundColor: primaryColor,
    ),

    );
  }
}
