import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'en_US.dart';
import 'tr_TR.dart';

class LocaleManager {
  static final LocaleManager _instance = LocaleManager._init();
  static LocaleManager get instance => _instance;
  SharedPreferences? _preferences;

  LocaleManager._init();

  final String _localeKey = 'locale';

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static const trLocale = Locale('tr', 'TR');
  static const enLocale = Locale('en', 'US');

  List<Locale> get supportedLocales => [trLocale, enLocale];

  Locale get defaultLocale {
    final deviceLocale = WidgetsBinding.instance.window.locale;
    if (supportedLocales.contains(deviceLocale)) {
      return deviceLocale;
    }
    return enLocale;
  }

  Locale? getCurrentLocale() {
    final localeStr = _preferences?.getString(_localeKey);
    if (localeStr == null) return null;

    final localeParts = localeStr.split('_');
    if (localeParts.length != 2) return null;

    return Locale(localeParts[0], localeParts[1]);
  }

  Future<void> setLocale(Locale locale) async {
    await _preferences?.setString(
        _localeKey, '${locale.languageCode}_${locale.countryCode}');
  }

  String getString(String key) {
    final currentLocale = getCurrentLocale() ?? defaultLocale;
    final translations = currentLocale == trLocale ? trTR : enUS;
    return translations[key] ?? key;
  }
}
