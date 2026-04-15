import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superweb3wallet/data/datasources/preferences_storage.dart';

/// Controls Material [ThemeMode] backed by Hive preferences.
class ThemeCubit extends Cubit<ThemeMode> {
  /// Creates cubit and loads persisted mode.
  ThemeCubit(this._prefs) : super(ThemeMode.system) {
    _load();
  }

  final PreferencesStorage _prefs;

  Future<void> _load() async {
    final ThemeMode mode = await _prefs.readThemeMode();
    emit(mode);
  }

  /// Persists and applies a new [ThemeMode].
  Future<void> setTheme(ThemeMode mode) async {
    await _prefs.saveThemeMode(mode);
    emit(mode);
  }
}
