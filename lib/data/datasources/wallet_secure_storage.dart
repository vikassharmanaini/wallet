import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Typed accessors for wallet material stored in secure hardware-backed storage.
class WalletSecureStorage {
  /// Creates secure storage accessor.
  WalletSecureStorage(this._storage);

  final FlutterSecureStorage _storage;

  static const String _encryptedMnemonicKey = 'encrypted_mnemonic_v1';
  static const String _saltKey = 'mnemonic_salt_v1';
  static const String _primaryAddressKey = 'primary_address_v1';

  /// Persists encrypted mnemonic payload and derived primary address metadata.
  Future<void> writeWalletSecrets({
    required String encryptedMnemonic,
    required String saltBase64,
    required String primaryAddress,
  }) async {
    await _storage.write(key: _encryptedMnemonicKey, value: encryptedMnemonic);
    await _storage.write(key: _saltKey, value: saltBase64);
    await _storage.write(key: _primaryAddressKey, value: primaryAddress);
  }

  /// Reads encrypted mnemonic ciphertext, if present.
  Future<String?> readEncryptedMnemonic() =>
      _storage.read(key: _encryptedMnemonicKey);

  /// Reads PBKDF2 salt for decryption.
  Future<String?> readSalt() => _storage.read(key: _saltKey);

  /// Reads cached primary account address.
  Future<String?> readPrimaryAddress() =>
      _storage.read(key: _primaryAddressKey);

  /// Deletes all wallet secrets from secure storage.
  Future<void> clearAll() async {
    await _storage.delete(key: _encryptedMnemonicKey);
    await _storage.delete(key: _saltKey);
    await _storage.delete(key: _primaryAddressKey);
  }
}
