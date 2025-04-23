import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  late SharedPreferences _prefs;

  SharedPreferencesService._privateConstructor();

  static final SharedPreferencesService instance = SharedPreferencesService._privateConstructor();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Generic method to get a value
  T? getValue<T>(String key) {
    return _prefs.get(key) as T?;
  }

  // Generic method to set a value
  Future<bool> setValue<T>(String key, T value) async {
    if (value is String) {
      return await _prefs.setString(key, value);
    } else if (value is int) {
      return await _prefs.setInt(key, value);
    } else if (value is double) {
      return await _prefs.setDouble(key, value);
    } else if (value is bool) {
      return await _prefs.setBool(key, value);
    } else if (value is List<String>) {
      return await _prefs.setStringList(key, value);
    }

    return false; // Unsupported data type
  }

  // Remove a value
  Future<bool> removeValue(String key) async {
    return await _prefs.remove(key);
  }

  // Clear all values
  Future<bool> clear() async {
    return await _prefs.clear();
  }
}
