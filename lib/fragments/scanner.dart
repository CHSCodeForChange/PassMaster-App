// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:qr_mobile_vision/qr_camera.dart';

// import '../models/currentuser.dart';
// import '../api/pass.dart';

// class Scanner extends StatefulWidget {

//   CurrentUserModel user;

//   Scanner(this.user);

//   @override
//   ScannerState createState() => new ScannerState(this.user);

// }

// class ScannerState extends State<Scanner> {

//   CurrentUserModel user;

//   ScannerState(this.user);

//   @override 
//   Widget build(BuildContext context) {
//     return new SizedBox(
//       width: 300.0,
//       height: 600.0,
//       child: new QrCamera(
//         qrCodeCallback: (code) {
//           List<String> data = code.split(",");
//           PassAPI().getData(user.token, int.parse(data.elementAt(0)), data.elementAt(1), data.elementAt(2));
//         },
//       ),
//     );
//   }

// }