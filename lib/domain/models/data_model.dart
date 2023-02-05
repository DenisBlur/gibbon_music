import 'package:shared_preferences/shared_preferences.dart';

class DataModel {

  SharedPreferences? prefs;

  Future<bool?> findKey(String key) async {
    prefs ??= await SharedPreferences.getInstance();
    return prefs!.containsKey(key);
  }

  Future<void> writeStringData(String key, String value) async {
    prefs ??= await SharedPreferences.getInstance();
    await prefs!.setString(key, value);
  }

  Future<String> readStringData(String key) async {
    prefs ??= await SharedPreferences.getInstance();
    return prefs!.getString(key).toString();
  }

  Future<void> writeBoolData(String key, bool value) async {
    prefs ??= await SharedPreferences.getInstance();
    await prefs!.setBool(key, value);
  }

  Future<bool?> readBoolData(String key) async {
    prefs ??= await SharedPreferences.getInstance();
    return prefs!.getBool(key);
  }

  Future<void> writeIntData(String key, int value) async {
    prefs ??= await SharedPreferences.getInstance();
    await prefs!.setInt(key, value);
  }

  Future<int?> readIntData(String key) async {
    prefs ??= await SharedPreferences.getInstance();
    return prefs!.getInt(key);
  }

}