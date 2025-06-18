import 'package:shared_preferences/shared_preferences.dart';

class MockData {
  static const String _userKey = 'registered_users';

  static Future<void> saveUser(
    String fullName,
    String phoneOrEmail,
    String password,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> users = prefs.getStringList(_userKey) ?? [];
    users.add('$fullName|$phoneOrEmail|$password');
    await prefs.setStringList(_userKey, users);
  }

  static Future<List<Map<String, String>>> getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> users = prefs.getStringList(_userKey) ?? [];
    return users.map((user) {
      final parts = user.split('|');
      return {
        'fullName': parts[0],
        'phoneOrEmail': parts[1],
        'password': parts[2],
      };
    }).toList();
  }

  static Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}
