import 'package:intl/intl.dart';

String timeFormat(date)  {
  return DateFormat('yyyy年MM月dd日 HH時mm分').format(DateTime.parse(date));
}