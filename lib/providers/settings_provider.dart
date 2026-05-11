import 'package:flutter/material.dart';

import '../services/storage_service.dart';
import '../utils/app_strings.dart';

class SettingsProvider extends ChangeNotifier {
  SettingsProvider(this._storageService);

  final StorageService _storageService;

  AppLanguage _language = AppLanguage.id;
  ThemeMode _themeMode = ThemeMode.dark;

  AppLanguage get language => _language;
  ThemeMode get themeMode => _themeMode;
  AppStrings get strings => AppStrings(_language);

  Future<void> loadSettings() async {
    _language = await _storageService.getLanguage();
    _themeMode = await _storageService.getThemeMode();
    notifyListeners();
  }

  Future<void> setLanguage(AppLanguage language) async {
    if (_language == language) return;
    _language = language;
    await _storageService.setLanguage(language);
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    if (_themeMode == themeMode) return;
    _themeMode = themeMode;
    await _storageService.setThemeMode(themeMode);
    notifyListeners();
  }
}
