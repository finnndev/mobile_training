import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/stylist_model.dart';

class StylistService {
  static const String _selectedStylistKey = 'selected_stylist';

  static Future<void> saveSelectedStylist(Stylist stylist) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedStylistKey, jsonEncode(stylist.toJson()));
  }

  static Future<Stylist?> getSelectedStylist() async {
    final prefs = await SharedPreferences.getInstance();
    final stylistString = prefs.getString(_selectedStylistKey);
    if (stylistString != null) {
      final json = jsonDecode(stylistString) as Map<String, dynamic>;
      return Stylist.fromJson(json);
    }
    return null;
  }

  static Future<void> clearSelectedStylist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_selectedStylistKey);
  }
}