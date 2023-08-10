import 'package:countries_navigator/core/services/services.dart';
import 'package:countries_navigator/core/services/services_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
///
///
class LocalStorageService {
  ///
  ///Constructor
  ///
  LocalStorageService({required SharedPreferences preferences}) {
    _logger.i('LocalStorageService(): init fun');
    _preferences = preferences;
  }
  static final _logger = locator<LogService>();

  static late SharedPreferences _preferences;

  /// updated _saveToDisk function that handles all types
  void saveToDisk<T>(String key, T content) {
    _logger.log.i(
      '(TRACE) LocalStorageService:_saveToDisk. key: $key value: $content',
    );

    if (content is String) {
      _preferences.setString(key, content);
    }
    if (content is bool) {
      _preferences.setBool(key, content);
    }
    if (content is int) {
      _preferences.setInt(key, content);
    }
    if (content is double) {
      _preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences.setStringList(key, content);
    }
  }

  /// updated _removeFromDisk function that handles all types
  Future<bool> removeFromDisk<T>(String key) {
    _logger.log.i('(TRACE) LocalStorageService:Remove from desk. key: $key');

    return _preferences.remove(key);
  }

  ///
  /// get value from disk
  ///
  dynamic getFromDisk(String key) {
    final value = _preferences.get(key);
    _logger.log
        .i('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }

  ///
  /// clear the entire storage
  ///
  Future<bool> clearStorage() {
    _logger.log.i('(TRACE) LocalStorageService:clearStorage');
    return _preferences.clear();
  }
}
