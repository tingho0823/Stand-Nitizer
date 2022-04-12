String getDate(){
  DateTime now = DateTime.now();
  String date = now.year.toString() + '-' +  now.month.toString().padLeft(2,'0') + '-' + now.day.toString().padLeft(2,'0');
  return date;
}

String getTime(){

  int hour;
  String timePeriod = '';

  DateTime now = DateTime.now();
  if (now.hour == 0){
    timePeriod = ' AM';
    hour = 12;
  }

  else if (now.hour <= 11 ){
    timePeriod = ' AM';
    hour = now.hour;
  }

  else if (now.hour == 12) {
    timePeriod = ' PM';
    hour = now.hour;
  }

  else{
    timePeriod = ' PM';
    hour = now.hour - 12;
  }

  String time = hour.toString() + ':' + now.minute.toString().padLeft(2,'0') + timePeriod;
  return time;
}

String getDateTime(){
  DateTime now = DateTime.now();
  String dateTime = now.toString();
  return dateTime;
}