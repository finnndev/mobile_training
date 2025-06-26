import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/service_model.dart';

class HairdressingService {
  static const String _selectedServicesKey = 'selected_services';

  static Future<void> saveSelectedServices(List<ServiceItem> services) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = services.map((service) => service.toJson()).toList();
    await prefs.setString(_selectedServicesKey, jsonEncode(jsonList));
  }

  static Future<List<ServiceItem>?> getSelectedServices() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_selectedServicesKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => ServiceItem.fromJson(json as Map<String, dynamic>)).toList();
    }
    return null;
  }

  static Future<void> clearSelectedServices() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_selectedServicesKey);
  }
}