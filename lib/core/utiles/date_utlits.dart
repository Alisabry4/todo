  import 'package:intl/intl.dart';

  extension DateEx on DateTime{
     //String get toFormattedDate =>'$day /$month /$year'; 
    String get toFormattedDate {
          DateFormat formmater =DateFormat('dd / MM / yyyy'); //view day name
          return formmater.format(this);

     }
    // String get dayName { //  دي هي دي 
    //   List<String>days=['MON','TUE','WED','THU','FRI','SAT','SUN']; 
    //   return days[weekday-1];
    // }
        String get getDayName { // هي دي 
          DateFormat formmater =DateFormat('E'); //view day name
          return formmater.format(this);
    }

  }

  // ممكن كمان م function 
    //       String  getDayName(DateTime date) {
    //       DateFormat formmater =DateFormat('E'); //view day name
    //       return formmater.format(date);
    // }

