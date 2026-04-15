import 'dart:typed_data';

import 'package:superweb3wallet/data/datasources/crypto_vault.dart';
import 'package:superweb3wallet/data/datasources/wallet_key_derivation.dart';
import 'package:superweb3wallet/data/datasources/wallet_secure_storage.dart';
import 'package:superweb3wallet/domain/repositories/wallet_repository.dart';

/// [WalletRepository] backed by secure storage and local crypto primitives.
class WalletRepositoryImpl implements WalletRepository {
  /// Creates repository with secure storage and crypto helpers.
  WalletRepositoryImpl(this._secureStorage);

  final WalletSecureStorage _secureStorage;

  @override
  Future<bool> hasWallet() async {
    final String? enc = await _secureStorage.readEncryptedMnemonic();
    return enc != null && enc.isNotEmpty;
  }

  @override
  Future<void> clearWallet() => _secureStorage.clearAll();

  @override
  Future<void> saveNewWallet({
    required String mnemonic,
    required String password,
  }) async {
    final ({String ciphertextBase64, String saltBase64}) envelope =
        CryptoVault.encrypt(plaintext: mnemonic, password: password);
    final Uint8List pk = WalletKeyDerivation.derivePrivateKeyFromMnemonic(
      mnemonic: mnemonic,
    );
    final String address =
        WalletKeyDerivation.addressFromPrivateKeyBytes(pk);
    await _secureStorage.writeWalletSecrets(
      encryptedMnemonic: envelope.ciphertextBase64,
      saltBase64: envelope.saltBase64,
      primaryAddress: address,
    );
  }

  @override
  Future<void> importMnemonic({
    required String mnemonic,
    required String password,
  }) =>
      saveNewWallet(mnemonic: mnemonic, password: password);

  @override
  Future<void> importPrivateKey({
    required String hexPrivateKey,
    required String password,
  }) async {
    final String address =
        WalletKeyDerivation.addressFromPrivateKeyHex(hexPrivateKey);
    final String normalized = hexPrivateKey.startsWith('0x') ||
            hexPrivateKey.startsWith('0X')
        ? hexPrivateKey.substring(2)
        : hexPrivateKey;
    final ({String ciphertextBase64, String saltBase64}) envelope =
        CryptoVault.encrypt(
      plaintext: 'RAWPK:$normalized',
      password: password,
    );
    await _secureStorage.writeWalletSecrets(
      encryptedMnemonic: envelope.ciphertextBase64,
      saltBase64: envelope.saltBase64,
      primaryAddress: address,
    );
  }

  @override
  Future<String?> primaryAddress() => _secureStorage.readPrimaryAddress();
}
