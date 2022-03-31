import 'package:adviser/infrastructure/datasources/theme_local_datasource.dart';
import 'package:adviser/infrastructure/exceptions/exceptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme_local_datasource_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late ThemeLocalDatasource themeLocalDatasource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    themeLocalDatasource =
        ThemeLocalDatasourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group("getCachedThemeData", () {
    const testThemeData = true;

    test(
        "should return a bool (theme data) if there is one stored in sharedPreferences.",
        () async {
      // arrange:
      when(mockSharedPreferences.getBool(any)).thenReturn(testThemeData);

      // act:
      final result = await themeLocalDatasource.getChachedThemeData();

      // assert:
      verify(mockSharedPreferences.getBool(CACHED_THEME_MODE));
      expect(result, testThemeData);
    });

    test(
        "should return a CacheException if there is no value stored in sharedPreferences.",
        () async {
      // arrange:
      when(mockSharedPreferences.getBool(any)).thenThrow(CacheException());

      // act:
      final call = themeLocalDatasource.getChachedThemeData;

      // assert:
      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group("chacheThemeData", () {
    const testThemeData = true;
    test("should call shared preferences and to cache theme data.", () async {
      // arrange:
      when(mockSharedPreferences.setBool(any, any))
          .thenAnswer((_) async => testThemeData);

      // act:
      await themeLocalDatasource.cacheThemeData(mode: testThemeData);
      // assert:
      verify(mockSharedPreferences.setBool(CACHED_THEME_MODE, testThemeData));
    });
  });
}
