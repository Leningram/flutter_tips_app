import 'package:intl/intl.dart';

String formatNumber(int number) {
  var formatter = NumberFormat('#,###', 'en_US');
  return formatter.format(number).replaceAll(',', ' ');
}
