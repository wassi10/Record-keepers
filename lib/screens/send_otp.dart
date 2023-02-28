// import 'package:email_otp/email_otp.dart';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_new/theme.dart';
//
// import 'otp_screen.dart';
//
// class Emailotp extends StatefulWidget {
//   const Emailotp({Key? key}) : super(key: key);
//
//   @override
//   State<Emailotp> createState() => _EmailotpState();
// }
//
// class _EmailotpState extends State<Emailotp> {
//
//   TextEditingController email = TextEditingController();
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: defaultPadding,
//         child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//               const SizedBox(
//                 height: 250,
//               ),
//               Text(
//                 "Enter your Email",
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: primaryColor),
//               ),
//
//               SizedBox(height: 30,),
//
//               TextFormField(
//                 controller: email,
//                 decoration: InputDecoration(
//
//                   suffixIcon: IconButton(
//                     onPressed: () async {
//
//                     },
//                     icon: const Icon(
//                       Icons.send_rounded,
//                       color: primaryColor,
//                     ),
//                   ),
//                   hintText: "Enter Email",
//
//                 ),
//               ),
//
//
//             ]
//         ),
//       ),
//     );
//   }
// }
