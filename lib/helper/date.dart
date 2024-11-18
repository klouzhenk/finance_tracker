import 'package:intl/intl.dart';

class DateHelper {
  static String dateToText(DateTime date) {
    return DateFormat('dd.MM.yyyy').format(date.toLocal());
  }
}
