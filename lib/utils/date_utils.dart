import 'package:intl/intl.dart';

DateTime parseApiDate(String? value) {
  if (value == null || value.isEmpty) return DateTime.now();
  return DateFormat('yyyy-MM-dd').parse(value);
}

String formatDisplayDate(DateTime date) {
  return DateFormat('dd MMM yyyy').format(date);
}
