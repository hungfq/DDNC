import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelpers {
  static const languageKey = "com.hungpq.language";
  static const tokenKey = "com.hungpq.token";
  static const themeModeKey = "com.hungpq.theme_mode";
  static const userIdKey = "com.hungpq.user_id";
  static const roleKey = "com.hungpq.role";

  static SharedPreferencesHelpers? _instance;
  static SharedPreferences? _preferences;

  static Future<SharedPreferencesHelpers> getInstance(
      {SharedPreferences? preferences}) async {
    _instance ??= SharedPreferencesHelpers();

    if (preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    } else {
      _preferences = preferences;
    }

    return _instance!;
  }

  T? getFromDisk<T>(String key) {
    switch (T) {
      case String:
        return (_preferences!.get(key) ?? "") as T?;
      case bool:
        return (_preferences!.get(key) ?? false) as T?;
      case int:
        return _preferences!.get(key) as T?;
      case double:
        return _preferences!.get(key) as T?;
      default:
        return _preferences!.get(key) as T?;
    }
  }

  Future<void> saveToDisk<T>(String key, T content) async {
    if (content is String) {
      await _preferences!.setString(key, content);
    } else if (content is bool) {
      await _preferences!.setBool(key, content);
    } else if (content is int) {
      await _preferences!.setInt(key, content);
    } else if (content is double) {
      await _preferences!.setDouble(key, content);
    }
  }

  void clearSignInInfo() {
    saveToDisk(tokenKey, "");
    saveToDisk(userIdKey, "");
    saveToDisk(roleKey, "");
  }
}
