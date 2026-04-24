import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDark = prefs.getBool('isDarkMode') ?? false;
      emit(isDark ? ThemeMode.dark : ThemeMode.light);
    } catch (e) {
      emit(ThemeMode.light);
    }
  }

  Future<void> toggleTheme(bool isDark) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isDarkMode', isDark);
      emit(isDark ? ThemeMode.dark : ThemeMode.light);
    } catch (e) {
      emit(isDark ? ThemeMode.dark : ThemeMode.light);
    }
  }

  bool get isDarkMode => state == ThemeMode.dark;
}
