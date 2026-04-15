/// Global non-secret application constants.
abstract final class AppConstants {
  /// Hive box name for non-sensitive preferences.
  static const String preferencesBoxName = 'preferences';

  /// Hive key for the active EIP-155 chain id.
  static const String activeChainIdKey = 'active_chain_id';

  /// Secure storage key namespace prefix.
  static const String secureStoragePrefix = 'sw3w_';
}
