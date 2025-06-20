
import 'package:shared_preferences/shared_preferences.dart';
import '../models/stylist_model.dart';

class StylistService {
  static const String _selectedStylistKey = 'selected_stylist';


  static Future<void> saveSelectedStylist(Stylist stylist) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedStylistKey, _stylistToString(stylist));
  }

 
  static Future<Stylist?> getSelectedStylist() async {
    final prefs = await SharedPreferences.getInstance();
    final stylistString = prefs.getString(_selectedStylistKey);
    if (stylistString != null) {
      return _stringToStylist(stylistString);
    }
    return null;
  }


  static Future<void> clearSelectedStylist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_selectedStylistKey);
  }

  
  static String _stylistToString(Stylist stylist) {
    return '${stylist.name}|${stylist.image}';
  }

  
  static Stylist _stringToStylist(String stylistString) {
    final parts = stylistString.split('|');
    return Stylist(name: parts[0], image: parts[1]);
  }
}