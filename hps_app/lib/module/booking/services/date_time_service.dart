
import 'package:shared_preferences/shared_preferences.dart';
import '../models/date_time_model.dart';

class DateTimeService {
  static const String _selectedDateTimeKey = 'selected_date_time';

 
  static Future<void> saveSelectedDateTime(DateTimeSelection dateTime) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = dateTime.toJson();
    await prefs.setString(_selectedDateTimeKey, _encodeJson(jsonString));
  }


  static Future<DateTimeSelection?> getSelectedDateTime() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_selectedDateTimeKey);
    if (jsonString != null) {
      final json = _decodeJson(jsonString);
      return DateTimeSelection.fromJson(json);
    }
    return null;
  }


  static Future<void> clearSelectedDateTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_selectedDateTimeKey);
  }

  
  static String _encodeJson(Map<String, dynamic> json) {
    return json.toString(); 
  }


  static Map<String, dynamic> _decodeJson(String jsonString) {
   
    final parts = jsonString.replaceAll('{', '').replaceAll('}', '').split(', ');
    final json = <String, dynamic>{};
    for (var part in parts) {
      final keyValue = part.split(': ');
      if (keyValue.length == 2) {
        json[keyValue[0]] = keyValue[1];
      }
    }
    return json;
  }
}