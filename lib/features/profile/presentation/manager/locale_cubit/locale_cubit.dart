import 'dart:ui';
import 'package:coffee_app/core/services/app_locale.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('ar')) {
    _loadSavedLocale();
  }

  Future<void> changeLocale(Locale locale) async {
    AppLocale.update(locale);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', locale.languageCode);

    emit(locale);
  }

  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCode = prefs.getString('locale');

    if (savedCode != null) {
      final savedLocale = Locale(savedCode);
      AppLocale.update(savedLocale);
      emit(savedLocale);
    }
  }
}
