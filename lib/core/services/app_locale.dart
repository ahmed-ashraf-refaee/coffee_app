import 'dart:ui';

class AppLocale {
  static Locale _current = const Locale('en');

  static Locale get current => _current;

  static void update(Locale locale) {
    _current = locale;
  }
}
