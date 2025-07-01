import 'dart:convert';

import 'package:hps_app/module/menu/widgets/model%20.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScheduleService {
  static const String _key = 'schedule_data';

  static Future<List<ScheduleModel>> getSchedules() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString == null) return [];
    final List decoded = json.decode(jsonString);
    return decoded.map((e) => ScheduleModel.fromJson(e)).toList();
  }

  static Future<void> saveSchedules(List<ScheduleModel> list) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = json.encode(list.map((e) => e.toJson()).toList());
    await prefs.setString(_key, encoded);
  }

  static Future<void> addSchedule(ScheduleModel model) async {
    final list = await getSchedules();
    list.add(model);
    await saveSchedules(list);
  }

  static Future<void> updateAll(List<ScheduleModel> list) async {
    await saveSchedules(list);
  }
}