import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/date_time_model.dart';

class DateTimeService {
  static const String _selectedDateTimeKey = 'selected_date_time';

  static Future<void> saveSelectedDateTime(DateTimeSelection dateTime) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(dateTime.toJson());
    await prefs.setString(_selectedDateTimeKey, jsonString);
  }

  static Future<DateTimeSelection?> getSelectedDateTime() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_selectedDateTimeKey);
    if (jsonString != null) {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return DateTimeSelection.fromJson(json);
    }
    return null;
  }

  static Future<void> clearSelectedDateTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_selectedDateTimeKey);
  }
}