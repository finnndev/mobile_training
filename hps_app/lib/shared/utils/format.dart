import 'package:intl/intl.dart';

String formatCurrency(num value) {
  final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '', decimalDigits: 0);
  return formatter.format(value).trim();
}
