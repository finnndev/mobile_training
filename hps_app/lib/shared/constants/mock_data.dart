import 'package:shared_preferences/shared_preferences.dart';

class MockData {
  static const String _userKey = 'registered_users';

  static Future<void> saveUser(
    String fullName,
    String phone,
    String password, {
    String email = '',
  }) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> users = prefs.getStringList(_userKey) ?? [];
    users.add('$fullName|$phone|$email|$password');
    await prefs.setStringList(_userKey, users);
  }

  static Future<List<Map<String, String>>> getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> users = prefs.getStringList(_userKey) ?? [];
    return users.map((user) {
      final parts = user.split('|');
      return {
        'fullName': parts[0],
        'phone': parts.length > 1 ? parts[1] : '',
        'email': parts.length > 2 ? parts[2] : '',
        'password': parts.length > 3 ? parts[3] : '',
      };
    }).toList();
  }

  static Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}
