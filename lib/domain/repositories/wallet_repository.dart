/// Persistence and retrieval of wallet credentials and metadata.
abstract class WalletRepository {
  /// Returns true when encrypted wallet material exists on device.
  Future<bool> hasWallet();

  /// Removes encrypted wallet material and related secure keys.
  Future<void> clearWallet();
}
