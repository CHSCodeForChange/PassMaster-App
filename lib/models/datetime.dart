import 'package:flutter/material.dart';

class MyDateTime {
  static String getDate(date, {showYear: false, shortenedMonths: false}) {
    return getMonthName(date.month, shortened: shortenedMonths) + " " + date.day.toString() + (showYear ? ", " + date.year.toString() : "");
  }

  static String getDateJson(date) {
    return date.year.toString() + "-" + date.month.toString() + "-" + date.day.toString();
  }

  static String getMonthName(int month, {shortened: false}) {
    if(shortened){
      month += 12;
    }
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
      case 13:
        return "Jan";
      case 14:
        return "Feb";
      case 15:
        return "Mar";
      case 16:
        return "Apr";
      case 17:
        return "May";
      case 18:
        return "Jun";
      case 19:
        return "Jul";
      case 20:
        return "Aug";
      case 21:
        return "Sep";
      case 22:
        return "Oct";
      case 23:
        return "Nov";
      case 24:
        return "Dec";
    }
    return "Invalid month integer.";
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

  static String getTime(TimeOfDay time, {withAMPM: true}) {
    if (time == null) {
      return "";
    } else {
      String hour = (time.hour%12 == 0 ? 12 : time.hour%12).toString();
      String minute =(time.minute > 10 ? "" : "0") + time.minute.toString();
      String ampm = time.hour >= 12 ? "PM" : "AM";
      return hour + ":" + minute + (withAMPM ? " " + ampm : "");
    }
  }

  static bool isPM(TimeOfDay time) {
    if(time == null) {
      return null;
    }
    return time.hour >= 12;
  }

  static String getTimeJson(TimeOfDay time) {
    return time != null ? time.hour.toString() + ":" + time.minute.toString() : "";
  }
}