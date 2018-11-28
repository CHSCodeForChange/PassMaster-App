import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

import '../models/currentuser.dart';
import '../api/pass.dart';

class Scanner {

  static Future scan(CurrentUserModel user) async {
    String code;
    try {
      code = await BarcodeScanner.scan();
      List<String> data = code.split(",");
      PassAPI().getData(user.token, int.parse(data.elementAt(0)), data.elementAt(1), data.elementAt(2));
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        code = 'The user did not grant the camera permission!';
      } else {
        code = 'Unknown error: $e';
      }
    } on FormatException{
      code = 'null (User returned using the "back"-button before scanning anything. Result)';
    } catch (e) {
      code = 'Unknown error: $e';
    }
    print(code);
  }
}