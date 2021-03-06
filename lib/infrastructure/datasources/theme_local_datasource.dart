import 'package:adviser/infrastructure/exceptions/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

const CACHED_THEME_MODE = "CACHED_THEME_MODE";

abstract class ThemeLocalDatasource {
  Future<bool> getChachedThemeData();
  Future<bool> getUseSystemTheme();
  Future<void> cacheThemeData({required bool mode});
  Future<void> cacheUseSystemThemeData({required bool mode});
}

class ThemeLocalDatasourceImpl implements ThemeLocalDatasource {
  ThemeLocalDatasourceImpl({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  @override
  Future<void> cacheThemeData({required bool mode}) {
    return sharedPreferences.setBool(CACHED_THEME_MODE, mode);
  }

  @override
  Future<bool> getChachedThemeData() async {
    try {
      final modeBool = sharedPreferences.getBool(CACHED_THEME_MODE);
      return Future.value(modeBool);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUseSystemThemeData({required bool mode}) {
    // TODO: implement cacheUseSystemThemeData
    throw UnimplementedError();
  }

  @override
  Future<bool> getUseSystemTheme() {
    // TODO: implement getUseSystemTheme
    throw UnimplementedError();
  }
}
