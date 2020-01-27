import 'package:shared_preferences/shared_preferences.dart';

class SharedManager {
  SharedPreferences _preferences;

  static SharedManager instance = SharedManager._privateConstructor();
  SharedManager._privateConstructor();

  static Future<void> init() async {
    instance._preferences = await SharedPreferences.getInstance();
  }

  String getStringValue(SharedKeys key) =>
      _preferences.getString(key.toString()) ?? "";

  Future<void> saveString(SharedKeys key, String value) async {
    await _preferences.setString(key.toString(), value);
  }

  Future<void> clear() async {
    await _preferences.clear();
  }
}

enum SharedKeys { TOKEN }
