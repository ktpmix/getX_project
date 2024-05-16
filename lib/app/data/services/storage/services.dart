import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:getx_prac/app/core/utils/key.dart';

class StorageService extends GetxService {
  late SharedPreferences _prefs;

  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    if(_prefs.containsKey(taskKey) == false){
      _prefs.setString(taskKey, '[]');
    }
    
    return this;
  }

  T read<T>(String key) {
    return _prefs.get(key) as T;
  }

  void write(String key, dynamic value) async {
    if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    } else if (value is bool) {
      await _prefs.setBool(key, value);
    } else if (value is String) {
      await _prefs.setString(key, value);
    } else if (value is List<String>) {
      await _prefs.setStringList(key, value);
    } else {
      throw Exception('Invalid value type');
    }
  }
}
