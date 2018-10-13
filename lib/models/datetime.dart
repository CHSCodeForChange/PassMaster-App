import 'package:flutter/material.dart';

class MyDateTime {
  static String getDate(date) {
    return getMonthName(date.month) + " " + date.day.toString() + ", " + date.year.toString();
  }

  static String getDateJson(date) {
    return date.year.toString() + "-" + date.month.toString() + "-" + date.day.toString();
  }

  static String getMonthName(int month) {
    switch(month) {
      case 1:
        return "January";
      case 2:
        return "Feburary";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
    }
  }

  static TimeOfDay parseTime(String time) {
    TimeOfDay parsedTime;
    if (time != null) {
      List<String> parts = time.split(":");
      parsedTime =  new TimeOfDay(
        hour: int.parse(parts.elementAt(0)), 
        minute: int.parse(parts.elementAt(1)),
      );
    } else {
      parsedTime = null;
    }
    return parsedTime;
  }

  static String getTime(TimeOfDay time) {
    if (time == null) {
      return "";
    } else {
      String hour = (time.hour%12 == 0 ? 12 : time.hour%12).toString();
      String minute =(time.minute > 10 ? "" : "0") + time.minute.toString();
      String ampm = time.hour >= 12 ? "PM" : "AM";
      return hour + ":" + minute + " " + ampm;
    }
  }

  static String getTimeJson(TimeOfDay time) {
    return time != null ? time.hour.toString() + ":" + time.minute.toString() : "";
  }
}