
import 'package:flutter/cupertino.dart';
import 'package:flutter_new/theme.dart';

class Buttons extends StatelessWidget {

  final String buttonText;
  Buttons({required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(

      alignment: Alignment.center,

      height: MediaQuery.of(context).size.height*0.06,
      width: double.infinity,

      //button decoration
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), color: primaryColor,
      ),

      //decorate button text
      child: Text(buttonText,
      style: textButton.copyWith(color: whiteColor),
      ),
    );
  }

}
