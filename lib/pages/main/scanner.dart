// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:qr_mobile_vision/qr_camera.dart';
// import 'package:qr_mobile_vision/qr_mobile_vision.dart';
// import '../../api/pass.dart';
// import '../../models/currentuser.dart';

// class Scanner extends StatelessWidget {
//   final CurrentUserModel user;
//   Scanner(this.user);

//   @override
//   Widget build(BuildContext context) {
//     return new SizedBox(
//       width: 300.0,
//       height: 600.0,
//       child: new QrCamera(
//         qrCodeCallback: (code) {
//           List<String> data = code.split(",");
//           PassAPI().getData(user.token, int.parse(data.elementAt(0)), data.elementAt(0), data.elementAt(0));
//         },
//       ),
//     );
//   }
        
// }
