import 'package:adviser/domain/failures/failures.dart';
import 'package:adviser/domain/repositories/theme_repository.dart';
import 'package:adviser/infrastructure/datasources/theme_local_datasource.dart';
import 'package:adviser/infrastructure/exceptions/exceptions.dart';
import 'package:adviser/infrastructure/repositories/theme_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'theme_repository_test.mocks.dart';

@GenerateMocks([ThemeLocalDatasource])
void main() {
  late MockThemeLocalDatasource mockThemeLocalDatasource;
  late ThemeRepository themeRepository;

  setUp(() {
    mockThemeLocalDatasource = MockThemeLocalDatasource();
    themeRepository =
        ThemeRepositoryImpl(themeLocalDatasource: mockThemeLocalDatasource);
  });

  group("getThemeMode", () {
    const testThemeMode = true;
    test("should creturn theme mode if cached data is present", () async {
      // arrange:
      when(mockThemeLocalDatasource.getChachedThemeData())
          .thenAnswer((_) async => testThemeMode);

      // act:
      final result = await themeRepository.getThemeMode();

      // assert:
      expect(result, Right(testThemeMode));
      verify(mockThemeLocalDatasource.getChachedThemeData());
      verifyNoMoreInteractions(mockThemeLocalDatasource);
    });

    test(
        "should return cache failure if local datasource throws a cache exception",
        () async {
      // arrange:
      when(mockThemeLocalDatasource.getChachedThemeData())
          .thenThrow(CacheException());

      // act:
      final result = await themeRepository.getThemeMode();

      // assert:
      expect(result, Left(CacheFailure()));
      verify(mockThemeLocalDatasource.getChachedThemeData());
      verifyNoMoreInteractions(mockThemeLocalDatasource);
    });
  });

  group("setThemeMode", () {
    final testThemeMode = true;
    test("should call function to cache theme mode in local datasource", () {
      // arrange:
      when(mockThemeLocalDatasource.cacheThemeData(mode: anyNamed("mode")))
          .thenAnswer((_) async => true);

      // act:
      themeRepository.setThemeMode(mode: testThemeMode);
      // assert:
      verify(mockThemeLocalDatasource.cacheThemeData(mode: testThemeMode));
    });
  });
}
