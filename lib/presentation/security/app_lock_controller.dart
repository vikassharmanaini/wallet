import 'package:flutter/material.dart';
import 'package:superweb3wallet/data/datasources/preferences_storage.dart';

/// Coordinates auto-lock state and notifies [GoRouter] via [notifyListeners].
class AppLockController extends ChangeNotifier with WidgetsBindingObserver {
  /// Creates controller with preference-backed auto-lock policy.
  AppLockController(this._prefs);

  final PreferencesStorage _prefs;

  bool _locked = false;
  DateTime? _backgroundedAt;

  /// Whether the user must unlock before using the app.
  bool get locked => _locked;

  /// Installs the lifecycle observer; call once at startup.
  void attach() {
    WidgetsBinding.instance.addObserver(this);
  }

  /// Removes the lifecycle observer on shutdown.
  void detach() {
    WidgetsBinding.instance.removeObserver(this);
  }

  /// Immediately locks the app (used after timeout or manual lock).
  void lockNow() {
    _locked = true;
    notifyListeners();
  }

  /// Clears lock after successful authentication.
  void unlock() {
    _locked = false;
    notifyListeners();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _backgroundedAt = DateTime.now();
    } else if (state == AppLifecycleState.resumed) {
      _evaluateLockAfterResume();
    }
  }

  Future<void> _evaluateLockAfterResume() async {
    final int minutes = await _prefs.readAutoLockMinutes();
    if (minutes <= 0) {
      return;
    }
    final DateTime? at = _backgroundedAt;
    if (at == null) {
      return;
    }
    if (DateTime.now().difference(at) > Duration(minutes: minutes)) {
      lockNow();
    }
  }
}
