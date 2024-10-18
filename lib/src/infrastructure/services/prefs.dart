import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  SharedPreferences prefs = GetIt.I<SharedPreferences>();

  static const String _firstLaunchDateKey = 'firstLaunchDate';
  static const String _firstDateKey = 'firstDate';

  void saveFirstLaunchDate() async {
    await prefs.setString(_firstLaunchDateKey, DateTime.now().toString());
  }

  DateTime getFirstLaunchDate() {
    String firstLaunchDateString = prefs.getString(_firstLaunchDateKey) ?? '';
    DateTime? firstLaunchDate;

    if (firstLaunchDateString.isNotEmpty) {
      firstLaunchDate = DateTime.parse(firstLaunchDateString);
    }
    return firstLaunchDate ?? DateTime.now();
  }

  void saveFirstDate(bool value) async {
    await prefs.setBool(_firstDateKey, value);
  }

  bool getFirstDate() {
    return prefs.getBool(_firstDateKey) ?? false;
  }

}
