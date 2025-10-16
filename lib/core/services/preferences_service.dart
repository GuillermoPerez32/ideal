import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _themeKey = 'theme_mode';
  static const String _localeKey = 'locale';
  static const String _currencyKey = 'currency';

  final SharedPreferences _prefs;

  PreferencesService(this._prefs);

  static Future<PreferencesService> create() async {
    final prefs = await SharedPreferences.getInstance();
    return PreferencesService(prefs);
  }

  // Theme
  String getThemeMode() => _prefs.getString(_themeKey) ?? 'system';
  Future<void> setThemeMode(String mode) => _prefs.setString(_themeKey, mode);

  // Locale
  String getLocale() => _prefs.getString(_localeKey) ?? 'es';
  Future<void> setLocale(String locale) => _prefs.setString(_localeKey, locale);

  // Currency
  String getCurrency() => _prefs.getString(_currencyKey) ?? 'USD';
  Future<void> setCurrency(String currency) =>
      _prefs.setString(_currencyKey, currency);

  // Clear cache
  Future<void> clearCache() async {
    final keys = _prefs.getKeys().where((key) => key.startsWith('cache_'));
    for (final key in keys) {
      await _prefs.remove(key);
    }
  }
}
