import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_new/screens/buttons.dart';
import 'package:flutter_new/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class Sureparticipate extends StatefulWidget {
  Sureparticipate(this.end,this.endDate, this.title, this.details, this.name, this.url,
      {super.key});
  String details, title, name, endDate, url,end;

  @override
  State<Sureparticipate> createState() => _SureparticipateState();
}

class _SureparticipateState extends State<Sureparticipate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Details',
          style: TextStyle(
              fontSize: 22, color: whiteColor, fontWeight: FontWeight.w700),
        ),
        elevation: 0,
        backgroundColor: primaryColor,
        // this is for remove the back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MaterialButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              minWidth: MediaQuery.of(context).size.width,
              height: 80,
              color: Colors.white70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text("Author:  ",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          widget.name,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text("Title:  ",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child:
                            Text(widget.title, style: TextStyle(fontSize: 20)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text("Details:  ",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          widget.details,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text("End-Date of Participation:  ",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          widget.endDate,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            DateTime.now().toString().compareTo(widget.end)==-1 ?
            InkWell(
              
                onTap: () async {
                  if (await canLaunch(widget.url)) {
                    await launch(widget.url);
                  } else {
                    print("Coudnt launch");
                  }
                },
                
                child: Buttons(buttonText: "Participate in this Survey"))

                :InkWell(
              
                onTap: () async {
                 
                },
                
                child: Container(

      alignment: Alignment.center,

      height: MediaQuery.of(context).size.height*0.06,
      width: double.infinity,

      //button decoration
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), color: Colors.grey,
      ),

      //decorate button text
      child: Text("This Survey is ended",
      style: textButton.copyWith(color: whiteColor),
      ),
    ),
                )
          ],
        ),
      ),
    );
  }
}
