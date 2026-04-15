import 'package:local_auth/local_auth.dart';

/// Thin wrapper around [LocalAuthentication] for biometric prompts.
class LocalAuthService {
  /// Creates a service using the platform [LocalAuthentication] instance.
  LocalAuthService(
    this._localAuth, {
    Future<bool> Function(String localizedReason)? simulator,
  }) : _simulator = simulator;

  final LocalAuthentication _localAuth;
  final Future<bool> Function(String localizedReason)? _simulator;

  /// Returns whether any secure authentication hardware is available.
  Future<bool> canAuthenticate() async {
    if (_simulator != null) {
      return true;
    }
    final bool supported = await _localAuth.isDeviceSupported();
    final List<BiometricType> types = await _localAuth.getAvailableBiometrics();
    return supported && types.isNotEmpty;
  }

  /// Prompts the user to authenticate with biometrics or device PIN.
  Future<bool> authenticate({required String localizedReason}) async {
    final Future<bool> Function(String localizedReason)? sim = _simulator;
    if (sim != null) {
      return sim(localizedReason);
    }
    try {
      return _localAuth.authenticate(
        localizedReason: localizedReason,
        options: const AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: true,
        ),
      );
    } catch (_) {
      return false;
    }
  }
}
