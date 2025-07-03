import 'package:hps_app/module/menu/widgets/model%20.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoriteService {
  static const _key = 'favorite_orders';

  static Future<List<ScheduleModel>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_key) ?? [];
    return data.map((e) => ScheduleModel.fromJson(json.decode(e))).toList();
  }

  static Future<void> addFavorite(ScheduleModel model) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_key) ?? [];
    data.add(json.encode(model.toJson()));
    await prefs.setStringList(_key, data);
  }

  static Future<void> removeFavorite(ScheduleModel model) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_key) ?? [];
    data.removeWhere((e) => json.encode(model.toJson()) == e);
    await prefs.setStringList(_key, data);
  }

  static Future<bool> isFavorite(ScheduleModel model) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_key) ?? [];
    return data.contains(json.encode(model.toJson()));
  }
}
