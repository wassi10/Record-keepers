import 'package:flutter/material.dart';
import '../theme.dart';

import 'make_payments.dart';

class CreateSurveyQuestion extends StatefulWidget {
  const CreateSurveyQuestion({Key? key}) : super(key: key);

  @override
  State<CreateSurveyQuestion> createState() => _CreateSurveyQuestionState();
}

class _CreateSurveyQuestionState extends State<CreateSurveyQuestion> {


  int dataToChange = 1; // for increasing value
  void changeData(){
    setState(() {
      dataToChange +=1;
    });
  }

  void removeData(){
    setState(() {
      dataToChange -=1;
    });
  }

  bool _isExpanded = false;


  bool isStrechedDropDown = false;
  // //we can add more question
  List<TextEditingController> listController = [TextEditingController()];



  @override
  Widget build(BuildContext context) {

    return Scaffold(


      appBar: AppBar(
        title: const Text('Survey Questions', style: TextStyle(color: whiteColor), ),
        elevation: 0,
        backgroundColor: primaryColor,
      ),

      body: Padding(
        padding: defaultPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              const SizedBox(
                height: 30,),
              //survey Duration

              Text("Total  $dataToChange Questions",
                  style: const TextStyle(fontSize: 22,fontFamily: 'poppins',
                      fontWeight: FontWeight.w600, color: blackColor)
              ),

              const SizedBox(
                height: 20,
              ),

              //add button
              FloatingActionButton.small(
                 onPressed: () {

                   changeData();
                   setState(() {
                     listController.add(TextEditingController());
                   });
                 },

                child: const Icon(Icons.add),
                backgroundColor: primaryColor,
              ),

              const SizedBox(
                height: 30,
              ),


         Container(
           color: primaryColor,
           child:  Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Container(

                 child: Text('  Question 1', style: TextStyle(fontSize: 20,fontFamily: 'poppins',
                     fontWeight: FontWeight.w500, color: whiteColor),
                 ),
               ),

               ExpandIcon(
                 isExpanded: _isExpanded,
                 expandedColor: whiteColor,
                 onPressed: (bool isExpanded) {
                   setState(() {
                     _isExpanded = !isExpanded;
                   });
                 },
               ),
             ],
           ),
         ),
             if(_isExpanded)
               const Padding(
                   padding: defaultPadding,

                 child: Text("Question",style: TextStyle(fontSize: 18,fontFamily: 'poppins',
                     fontWeight: FontWeight.w500, color: blackColor),
                 ),
               ),



              // ListView.builder(
              //   // padding: defaultPadding,
              //   shrinkWrap: true,
              //   itemCount: listController.length,
              //   itemBuilder: ( context, index) {
              //     return Row(
              //       children: [
              //         Expanded(
              //           child: Container(
              //             decoration: BoxDecoration(
              //                 border: Border.all(
              //                     color: blackColor, width: 1),
              //
              //                 borderRadius: BorderRadius.circular(5)
              //             ),
              //
              //             child: Column(
              //               children: [
              //                 Container(
              //                   width: double.infinity,
              //                   decoration: BoxDecoration(
              //                       border: Border.all(color: blackColor)
              //                   ),
              //
              //                   constraints: const BoxConstraints(
              //                     minHeight: 50,
              //                     minWidth: double.infinity,
              //                   ),
              //
              //                   child: Row(
              //                     children: [
              //                       const Expanded(
              //                         child: Padding(
              //                           padding: defaultPadding,
              //                           child: Text("Questions", style: TextStyle(fontSize: 20,fontFamily: 'poppins',
              //                               fontWeight: FontWeight.w500, color: blackColor),),
              //                         ),
              //                       ),
              //
              //                       // arrow down button
              //                       GestureDetector(
              //                         onTap: (){
              //
              //                           setState(() {
              //                             isStrechedDropDown = !isStrechedDropDown;
              //
              //                           });
              //                         },
              //                         child: Padding(
              //                           padding: const EdgeInsets.only(right: 10.0),
              //                           child: Icon( isStrechedDropDown ? Icons.keyboard_arrow_up:
              //                           Icons.keyboard_arrow_down),
              //
              //                         ),
              //                       ),
              //
              //
              //                       //For delete
              //                       index != 0
              //                           ?  GestureDetector(
              //                         onTap: (){
              //
              //                           removeData();
              //                           setState(() {
              //                             listController[index].clear();
              //                             listController[index].dispose();
              //                             listController.removeAt(index);
              //                           });
              //
              //                         },
              //                         child:const Padding(
              //                           padding: EdgeInsets.only(right: 10.0),
              //                           child: Icon(Icons.close),
              //                         ),
              //                       ): const SizedBox()
              //
              //                     ],
              //                   ),
              //                 ),
              //
              //
              //
              //               ],
              //
              //             ),
              //
              //           ),
              //
              //         ),
              //         const SizedBox(
              //           height: 20,
              //         ),
              //
              //       ],
              //
              //     );
              //   },
              // ),





              // creating textfield
              // Row(
              //   children: [
              //     Expanded(
              //       child: Container(
              //         decoration: BoxDecoration(
              //             border: Border.all(
              //                 color: blackColor, width: 1),
              //
              //             borderRadius: BorderRadius.circular(5)
              //         ),
              //
              //         child: Column(
              //           children: [
              //             Container(
              //               width: double.infinity,
              //               decoration: BoxDecoration(
              //                   border: Border.all(color: blackColor)
              //               ),
              //
              //               constraints: BoxConstraints(
              //                 minHeight: 50,
              //                 minWidth: double.infinity,
              //               ),
              //
              //               child: Row(
              //                 children: [
              //                   Expanded(
              //                       child: Padding(
              //                           padding: defaultPadding,
              //                         child: Text('Question 1', style: TextStyle(fontSize: 20,fontFamily: 'poppins',
              //                             fontWeight: FontWeight.w500, color: blackColor),),
              //                       ),
              //                   ),
              //
              //                   // arrow down button
              //                   GestureDetector(
              //                     onTap: (){
              //                       setState(() {
              //                         isStrechedDropDown = !isStrechedDropDown;
              //
              //                       });
              //                     },
              //                     child: Padding(
              //                         padding: EdgeInsets.only(right: 10.0),
              //                       child: Icon( isStrechedDropDown ? Icons.keyboard_arrow_up:
              //                       Icons.keyboard_arrow_down),
              //
              //                     ),
              //                   ),
              //
              //
              //                   //For delete
              //                   GestureDetector(
              //                     onTap: (){
              //
              //
              //                     },
              //                     child:Padding(
              //                         padding: EdgeInsets.only(right: 10.0),
              //                       child: Icon(Icons.close),
              //                     ),
              //                   )
              //
              //                 ],
              //               ),
              //             ),
              //           ],
              //
              //         ),
              //       ),
              //     ),
              //     SizedBox(
              //       height: 20,
              //     ),
              //   ],
              // ),



              const SizedBox(
                height: 20,
              ),





            ],

          ),
        ),
      ),


        floatingActionButton: FloatingActionButton.extended(
          onPressed:
              (){
            Navigator.push(context, MaterialPageRoute(builder:  (context) => const MakePayments(),),);
          },
          label: const Icon(Icons.save_rounded),
          backgroundColor: primaryColor,
        ),


    );
  }
}
