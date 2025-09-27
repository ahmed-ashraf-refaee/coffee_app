import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.dark) {
    loadTheme();
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDark');
    if (isDark != null) {
      emit(isDark ? ThemeMode.dark : ThemeMode.light);
    } else {
      emit(ThemeMode.system);
    }
  }

  Future<void> toggleTheme() async {
    final newTheme = state == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    emit(newTheme);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', newTheme == ThemeMode.dark);
  }
}
