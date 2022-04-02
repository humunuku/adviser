import 'package:adviser/domain/repositories/theme_repository.dart';
import 'package:flutter/material.dart';

abstract class ThemeService extends ChangeNotifier {
  late bool isDarkModeOn;
  Future<void> toggleTheme();
  Future<void> setTheme({required bool mode});
  Future<void> init();
}

class ThemeServiceImpl extends ChangeNotifier implements ThemeService {
  ThemeServiceImpl({required this.themeRepository});

  final ThemeRepository themeRepository;

  @override
  bool isDarkModeOn = true;

  @override
  Future<void> setTheme({required bool mode}) async {
    isDarkModeOn = mode;
    notifyListeners();
    await themeRepository.setThemeMode(mode: isDarkModeOn);
    return;
  }

  @override
  Future<void> toggleTheme() async {
    isDarkModeOn = !isDarkModeOn;
    await setTheme(mode: isDarkModeOn);
    return;
  }

  @override
  Future<void> init() async {
    final modeOrFailure = await themeRepository.getThemeMode();

    modeOrFailure.fold((failure) {
      setTheme(mode: true);
    }, (mode) {
      setTheme(mode: mode);
    });
  }
}
