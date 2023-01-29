import 'package:shared_preferences/shared_preferences.dart';

class DataModel {

  SharedPreferences? prefs;

  Future<void> writeStringData(String key, String value) async {
    if(prefs != null) {
      await prefs!.setString(key, value);
    } else {
      prefs = await SharedPreferences.getInstance();
      await prefs!.setString(key, value);
    }
  }

  Future<String> readStringData(String key) async {
    if(prefs != null) {
      return prefs!.getString(key).toString();
    } else {
      prefs = await SharedPreferences.getInstance();
      return prefs!.getString(key).toString();
    }
  }

}