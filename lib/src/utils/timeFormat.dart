import 'package:intl/intl.dart';

String timeFormat(date)  {
  return DateFormat('yyyy年MM月dd日 hh時mm分').format(DateTime.parse(date));
}