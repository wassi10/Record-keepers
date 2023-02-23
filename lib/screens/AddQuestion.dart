import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class AddQuestion extends StatefulWidget {
  AddQuestion(this.number, this.title, this.details, {Key? key})
      : super(key: key);
  dynamic number, title, details;
  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  List<bool> isEXpanded = List.filled(10, false);
  late List<String> Question;
  bool valueItem = false;

  late String chooseCategory = "-1";
  List<int> changeOption = List.filled(10, 1);
  int addOption(changeOption) {
    setState(() {
      changeOption += 1;
    });
    return changeOption;
  }

  int removeOption(changeOption) {
    setState(() {
      changeOption -= 1;
    });
    return changeOption;
  }

// //we can add more question

//option add

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Survey Questions',
          style: TextStyle(color: whiteColor),
        ),
        elevation: 0,
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: defaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
//survey Duration

            Text("Total   Questions",
                style: const TextStyle(
                    fontSize: 22,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w600,
                    color: blackColor)),

            const SizedBox(
              height: 20,
            ),

//add button

            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    bool EX = false;
                    return Container(
                        child: Column(children: [
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        color: primaryColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                '   Question ${index + 1}',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'poppins',
                                    fontWeight: FontWeight.w500,
                                    color: whiteColor),
                              ),
                            ),
                            ExpandIcon(
                              isExpanded: isEXpanded[index],
                              expandedColor: whiteColor,
                              onPressed: (bool isExpanded) {
                                setState(() {
                                  isEXpanded[index] = !isExpanded;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      if (isEXpanded[index])
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Question',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Type Question',
                                  contentPadding: EdgeInsets.all(10),
                                ),

                                onChanged: (value) {
                                  Question[index] = value;
                                },
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                'Type Of Answer',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              DropdownButtonFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.all(10),
                                ),
                                value: chooseCategory,
                                items: [
                                  DropdownMenuItem(
                                    child: Text("  Multiple Choice"),
                                    value: "-1",
                                  ),
                                  DropdownMenuItem(
                                    child: Text("  Open-ended answer"),
                                    value: "1",
                                  ),
                                ],
                                onChanged: (value) {
                                  if (value == "-1") {
                                    setState(() {
                                      valueItem = true;
                                    });
                                  } else if (value == "1") {
                                    setState(() {
                                      changeOption[index] = 0;
                                      valueItem = false;
                                    });
                                  }
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(children: [
                                Container(
                                    child: valueItem
                                        ? IconButton(
                                            onPressed: () {
                                              changeOption[index] = addOption(
                                                  changeOption[index]);
                                              setState(() {});
                                            },
                                            icon: Icon(Icons.add),
                                          )
                                        : null),
                                Container(
                                    child: valueItem
                                        ? IconButton(
                                            onPressed: () {
                                              changeOption[index] =
                                                  removeOption(
                                                      changeOption[index]);
                                              setState(() {});
                                            },
                                            icon: Icon(Icons.remove),
                                          )
                                        : null),
                              ]),
                              Container(
                                height: 90,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: changeOption[index],
                                    itemBuilder: (context, index) {
                                      return Container(
                                          child: valueItem
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Text(
                                                        'Option. ${index + 1}'),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextFormField(
                                                      onChanged: (value) {},
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        contentPadding:
                                                            EdgeInsets.all(10),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : null);
                                    }),
                              ),
                            ])
                    ]));
                  }),
            ),
          ],
        ),

// SizedBox(
        //   height: 30,
        // ),

        //option add
        // IconButton(
        //   onPressed: (){
        //     addOption();
        //     setState(() {
        //       listController.add(TextEditingController());
        //     });
        //   }, icon: Icon(Icons.add),
        //
        // ),
        //
        //
        // ListView.builder(
        //   padding: defaultPadding,
        //     shrinkWrap: true,
        //   itemCount: listController.length,
        //   itemBuilder: (context, index){
        //     return Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         SizedBox(
        //           height: 20,
        //         ),
        //         Text('Option. $changeOption'), SizedBox(height: 10,),
        //         TextFormField(
        //           decoration: InputDecoration(
        //             border: OutlineInputBorder(),
        //             contentPadding: EdgeInsets.all(10),
        //           ),
        //         )
        //       ],
        //     );
        //   }
        // ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final FirebaseAuth auth = FirebaseAuth.instance;
          User? user = auth.currentUser;
          String? uid = user?.uid;
          var data = {
            'tittle': widget.title,
            'description': widget.details,
            
          };

          CollectionReference ref = FirebaseFirestore.instance
              .collection('Surv')
              .doc(uid)
              .collection('SurveyID');
          ref.add(data).then((valu) {
            Question.forEach((element) {
              CollectionReference ref = FirebaseFirestore.instance
                  .collection('Question')
                  .doc(valu.id)
                  .collection('QuestionID');
              var data = {
                'Question': element,
              };
              ref.add(data);
            });
          });
        },
        label: const Text(
          "Save",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        backgroundColor: primaryColor,
      ),
    );
  }
}
