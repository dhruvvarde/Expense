
import 'package:intl/intl.dart';

class Utils {

  static String formatDate(DateTime date) {
    return DateFormat('MM.dd.yyyy').format(date);
  }

}
