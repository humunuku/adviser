import 'package:adviser/application/theme/theme_service.dart';
import 'package:adviser/domain/failures/failures.dart';
import 'package:adviser/domain/repositories/theme_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'theme_service_test.mocks.dart';

@GenerateMocks([ThemeRepository])
void main() {
  late MockThemeRepository mockThemeRepository;
  late ThemeService themeService;
  late int listenerCount; // For testing notifylisteners() method.

  setUp(() {
    listenerCount = 0;
    mockThemeRepository = MockThemeRepository();
    themeService = ThemeServiceImpl(themeRepository: mockThemeRepository)
      ..addListener(() {
        listenerCount += 1;
      }); // For testing notifylisteners() method. We ad a listener to theme service and add 1 if notifylistenters() was called. Then we can test for that.
  });

  test("check if default value for dark mode is true", () {
    // assert:
    expect(themeService.isDarkModeOn, true);
  });

  group("setThemeMode", () {
    const testMode = false;
    test(
        "should set theme to the parameter it gets and store theme information",
        () {
      // arrange:
      themeService.isDarkModeOn = true;

      when(mockThemeRepository.setThemeMode(mode: anyNamed("mode")))
          .thenAnswer((_) async => true);

      // act:
      themeService.setTheme(mode: testMode);

      // assert:
      expect(themeService.isDarkModeOn, testMode);
      verify(mockThemeRepository.setThemeMode(mode: testMode));
      expect(listenerCount, 1);
    });
  });

  group("toggleThemeMode", () {
    const testMode = false;
    test("should toggle theme mode, store theme information.", () async {
      // arrange:
      themeService.isDarkModeOn = true;
      when(mockThemeRepository.setThemeMode(mode: anyNamed("mode")))
          .thenAnswer((_) async => true);

      // act:
      await themeService.toggleTheme();

      // assert:
      expect(themeService.isDarkModeOn, testMode);
      verify(mockThemeRepository.setThemeMode(mode: testMode));
      expect(listenerCount, 1);
    });
  });

  group("init", () {
    const testMode = false;

    test(
        "should get a theme from local data source and use it and notify listeners.",
        () async {
      // arrange:
      themeService.isDarkModeOn = true;
      when(mockThemeRepository.getThemeMode())
          .thenAnswer((_) async => Right(testMode));

      // act:
      await themeService.init();

      // assert:
      expect(themeService.isDarkModeOn, testMode);
      verify(mockThemeRepository.getThemeMode());
      expect(listenerCount, 1);
    });

    test(
        "should start with dark mode if no theme is returned from local data storage.",
        () async {
      // arrange:
      themeService.isDarkModeOn = true;
      when(mockThemeRepository.getThemeMode())
          .thenAnswer((_) async => Left(CacheFailure()));

      // act:
      await themeService.init();

      // assert:
      expect(themeService.isDarkModeOn, true);
      verify(mockThemeRepository.getThemeMode());
      expect(listenerCount, 1);
    });
  });
}
