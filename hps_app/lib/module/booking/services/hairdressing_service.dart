
import 'package:shared_preferences/shared_preferences.dart';
import '../models/service_model.dart';
import 'dart:convert';

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
      final jsonList = jsonDecode(jsonString) as List;
      return jsonList.map((json) => ServiceItem.fromJson(json)).toList();
    }
    return null;
  }

  
  static Future<void> clearSelectedServices() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_selectedServicesKey);
  }
}