
import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static const String firstLaunchDateKey = 'firstLaunchDate';

  static Future<void> saveFirstLaunchDate() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(firstLaunchDateKey)) {
      final now = DateTime.now();
      await prefs.setString(firstLaunchDateKey, now.toIso8601String());
    }
  }

  static Future<DateTime?> getFirstLaunchDate() async {
    final prefs = await SharedPreferences.getInstance();
    final dateString = prefs.getString(firstLaunchDateKey);
    if (dateString != null) {
      return DateTime.parse(dateString);
    }
    return null;
  }
}