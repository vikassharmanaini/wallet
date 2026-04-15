/// Persistence and lifecycle for the user's non-custodial wallet.
abstract class WalletRepository {
  /// Returns true when encrypted wallet material exists on device.
  Future<bool> hasWallet();

  /// Removes encrypted wallet material and related secure keys.
  Future<void> clearWallet();

  /// Creates a new on-device wallet from a BIP39 [mnemonic] and [password].
  Future<void> saveNewWallet({
    required String mnemonic,
    required String password,
  });

  /// Imports an existing BIP39 [mnemonic] encrypted with [password].
  Future<void> importMnemonic({
    required String mnemonic,
    required String password,
  });

  /// Imports a raw hex private key (64 hex chars) encrypted with [password].
  Future<void> importPrivateKey({
    required String hexPrivateKey,
    required String password,
  });

  /// Returns the primary account address if a wallet exists.
  Future<String?> primaryAddress();
}
