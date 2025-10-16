import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/preferences_service.dart';

final preferencesServiceProvider = FutureProvider<PreferencesService>((ref) {
  return PreferencesService.create();
});

class SettingsState {
  final ThemeMode themeMode;
  final Locale locale;
  final String currency;

  const SettingsState({
    required this.themeMode,
    required this.locale,
    required this.currency,
  });

  SettingsState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
    String? currency,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      currency: currency ?? this.currency,
    );
  }
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  final PreferencesService _prefsService;

  SettingsNotifier(this._prefsService)
    : super(
        SettingsState(
          themeMode: _parseThemeMode(_prefsService.getThemeMode()),
          locale: Locale(_prefsService.getLocale()),
          currency: _prefsService.getCurrency(),
        ),
      );

  static ThemeMode _parseThemeMode(String mode) {
    switch (mode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final modeStr = mode.toString().split('.').last;
    await _prefsService.setThemeMode(modeStr);
    state = state.copyWith(themeMode: mode);
  }

  Future<void> setLocale(String languageCode) async {
    await _prefsService.setLocale(languageCode);
    state = state.copyWith(locale: Locale(languageCode));
  }

  Future<void> setCurrency(String currency) async {
    await _prefsService.setCurrency(currency);
    state = state.copyWith(currency: currency);
  }

  Future<void> clearCache() async {
    await _prefsService.clearCache();
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>(
  (ref) {
    final prefsService = ref.watch(preferencesServiceProvider).value;
    if (prefsService == null) {
      throw Exception('PreferencesService not initialized');
    }
    return SettingsNotifier(prefsService);
  },
);
