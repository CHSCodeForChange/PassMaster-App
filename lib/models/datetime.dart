class MyDateTime {
  DateTime datetime;

  MyDateTime(this.datetime);

  static now() {
    return MyDateTime(DateTime.now());
  }

  String getAMPM() {
    return this.datetime.hour <= 12 ? "AM" : "PM";
  }

  int getHour() {
    return this.datetime.hour % 12;
  }

  String getTime() {
    return getHour().toString() + ":" + this.datetime.minute.toString() + " " + getAMPM();
  }

  String getDate() {
    return this.datetime.month.toString() + "/" + this.datetime.day.toString() + "/" + datetime.year.toString();
  }
}