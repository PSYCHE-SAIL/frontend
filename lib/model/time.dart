class convertedTime{
  final DateTime dateTime;
  late String date;
  late String day;
  late String month;
  late String year;
  late String time;
  late Map<int,String> _dayToString;
  late Map<int,String> _monthToString;
   convertedTime({
     required this.dateTime
   }
   ) {
   _dayToString = {
     1 : "Monday",
     2 : "Tuesday",
     3 :"Wednesday",
     4 : "Thursday",
     5 : "Friday",
     6: "Saturday",
     7: "Sunday"
   };
  _monthToString = {
  1: "January",
  2: "February",
  3: "March",
  4: "April",
  5: "May",
  6: "June",
  7: "July",
  8: "August",
  9: "September",
  10: "October",
  11: "November",
  12: "December",
};


   }
   String _numberToOrdinal(int number) {
  if (number == null) {
    return '';
  }

  if (number % 100 >= 11 && number % 100 <= 13) {
    return '$number' + 'th';
  }

  switch (number % 10) {
    case 1:
      return '$number' + 'st';
    case 2:
      return '$number' + 'nd';
    case 3:
      return '$number' + 'rd';
    default:
      return '$number' + 'th';
  }
}

   

    Map<String,String>  toMap() {
      day = _dayToString[dateTime.weekday] ?? "Wrong Input";
      month = _monthToString[dateTime.month] ?? "Wrong Input";
      date = _numberToOrdinal(dateTime.day);
      time = '${dateTime.hour < 10 ? '0${dateTime.hour}' : dateTime.hour }:${dateTime.minute < 10 ? '0${dateTime.minute}' : dateTime.minute}';
      year = dateTime.year.toString();
      return {
       "day" : day,
       "date" : date,
       "month" : month,
       "year" : year,
       "time" : time
      };
    }

}