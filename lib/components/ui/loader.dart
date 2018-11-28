import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Loader extends StatelessWidget {

  final bool orange;

  Loader(this.orange);

  @override
  Widget build(BuildContext context) {
    return new CircularProgressIndicator(
      valueColor: new AlwaysStoppedAnimation<Color>(orange ? Colors.orangeAccent : Colors.white),
      strokeWidth: 5.0,
    );
  }
}