import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:superweb3wallet/core/constants/app_constants.dart';

/// Non-sensitive preferences persisted in Hive.
class PreferencesStorage {
  /// Opens the preferences box; safe to call once at startup.
  Future<void> init() async {
    await Hive.openBox<String>(AppConstants.preferencesBoxName);
  }

  Box<String> get _box => Hive.box<String>(AppConstants.preferencesBoxName);

  /// Persisted [ThemeMode] name: `system`, `light`, or `dark`.
  Future<void> saveThemeMode(ThemeMode mode) async {
    final String value = switch (mode) {
      ThemeMode.system => 'system',
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
    };
    await _box.put('theme_mode', value);
  }

  /// Reads stored [ThemeMode], defaulting to system.
  Future<ThemeMode> readThemeMode() async {
    final String? raw = _box.get('theme_mode');
    return switch (raw) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  /// Auto-lock duration after backgrounding; `0` means disabled.
  Future<void> saveAutoLockMinutes(int minutes) async {
    await _box.put('auto_lock_minutes', minutes.toString());
  }

  /// Reads auto-lock minutes; defaults to 5 minutes.
  Future<int> readAutoLockMinutes() async {
    final String? raw = _box.get('auto_lock_minutes');
    if (raw == null) {
      return 5;
    }
    return int.tryParse(raw) ?? 5;
  }
}
