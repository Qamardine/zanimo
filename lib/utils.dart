import 'package:shared_preferences/shared_preferences.dart';
import 'package:zanimo/constants.dart';

class SimplePreferences {
  static SharedPreferences _preferences =
      SharedPreferences.getInstance() as SharedPreferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setLongitude(double longitude) async =>
      await _preferences.setDouble(keyLongitude, longitude);

  static Future setLatitude(double latitude) async =>
      await _preferences.setDouble(keyLatitude, latitude);

  getLongitude() {
    return _preferences.getDouble(keyLongitude).toString();
  }

  getLatitude() {
    return _preferences.getDouble(keyLatitude).toString();
  }
}
