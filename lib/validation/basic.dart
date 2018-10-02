import './validation.dart';

class Basic extends Validation {
  String validate(value, String fieldname) {
    if (value.isEmpty) {
      return "Must provide a " + fieldname;
    }
  }
}