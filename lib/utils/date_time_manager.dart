import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeAgo;

class DateTimeManager {
  DateTimeManager._();

  static String getCurrentDateTime() {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  }

  static String toTimeAgo(String stringDate) {
    DateTime date = DateTime.parse(stringDate);
    return timeAgo.format(date.subtract(Duration(
        days: date.day,
        seconds: date.second,
        hours: date.hour,
        minutes: date.minute)));
  }
}
