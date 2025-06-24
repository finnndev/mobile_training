import 'package:intl/intl.dart';

String formatCurrency(num value) {
  final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '', decimalDigits: 0);
  return formatter.format(value).trim();
}

String formatFullDate(DateTime date) {
  const weekdays = {
    1: 'Thứ Hai',
    2: 'Thứ Ba',
    3: 'Thứ Tư',
    4: 'Thứ Năm',
    5: 'Thứ Sáu',
    6: 'Thứ Bảy',
    7: 'Chủ Nhật',
  };
  final weekday = weekdays[date.weekday] ?? '';
  final month = date.month.toString().padLeft(2, '0');
  final year = date.year;
  return "${weekday}, ${date.day} tháng $month năm $year";
}
