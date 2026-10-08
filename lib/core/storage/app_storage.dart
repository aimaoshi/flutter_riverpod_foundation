import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  const AppStorage(this._preferences);

  final SharedPreferences _preferences;

  bool containsKey(String key) => _preferences.containsKey(key);

  Set<String> get keys => Set.unmodifiable(_preferences.getKeys());

  String getString(String key, {String fallback = ''}) =>
      _preferences.getString(key) ?? fallback;

  int getInt(String key, {int fallback = 0}) =>
      _preferences.getInt(key) ?? fallback;

  double getDouble(String key, {double fallback = 0}) =>
      _preferences.getDouble(key) ?? fallback;

  bool getBool(String key, {bool fallback = false}) =>
      _preferences.getBool(key) ?? fallback;

  List<String> getStringList(String key) =>
      List.unmodifiable(_preferences.getStringList(key) ?? const []);

  T? getJson<T>(String key, T Function(Object? json) decoder) {
    final value = _preferences.getString(key);
    if (value == null || value.isEmpty) {
      return null;
    }

    try {
      return decoder(jsonDecode(value));
    } on FormatException {
      return null;
    }
  }

  Future<bool> setString(String key, String value) =>
      _preferences.setString(key, value);

  Future<bool> setInt(String key, int value) => _preferences.setInt(key, value);

  Future<bool> setDouble(String key, double value) =>
      _preferences.setDouble(key, value);

  Future<bool> setBool(String key, bool value) =>
      _preferences.setBool(key, value);

  Future<bool> setStringList(String key, List<String> value) =>
      _preferences.setStringList(key, value);

  Future<bool> setJson(String key, Object value) =>
      _preferences.setString(key, jsonEncode(value));

  Future<bool> remove(String key) => _preferences.remove(key);

  Future<void> removeByPrefix(String prefix) async {
    final keysToRemove = keys.where((key) => key.startsWith(prefix));
    await Future.wait(keysToRemove.map(remove));
  }

  Future<bool> clear() => _preferences.clear();
}
