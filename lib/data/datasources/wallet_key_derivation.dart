import 'dart:typed_data';

import 'package:bip32/bip32.dart' as bip32;
import 'package:bip39/bip39.dart' as bip39;
import 'package:hex/hex.dart';
import 'package:web3dart/web3dart.dart';

/// BIP32/BIP44 Ethereum key derivation helpers (path `m/44'/60'/0'/0/{index}`).
class WalletKeyDerivation {
  WalletKeyDerivation._();

  /// Default BIP44 prefix for Ethereum accounts.
  static const String ethereumDerivationPrefix = "m/44'/60'/0'/0/";

  /// Derives secp256k1 private key bytes for [accountIndex] from [mnemonic].
  static Uint8List derivePrivateKeyFromMnemonic({
    required String mnemonic,
    int accountIndex = 0,
  }) {
    final Uint8List seed = bip39.mnemonicToSeed(mnemonic);
    final bip32.BIP32 root = bip32.BIP32.fromSeed(seed);
    final bip32.BIP32 child = root.derivePath(
      '$ethereumDerivationPrefix$accountIndex',
    );
    final Uint8List? pk = child.privateKey;
    if (pk == null) {
      throw StateError('Unable to derive private key');
    }
    return pk;
  }

  /// Converts raw secp256k1 private key bytes to an Ethereum address hex string.
  static String addressFromPrivateKeyBytes(Uint8List privateKeyBytes) {
    final EthPrivateKey credentials = EthPrivateKey(privateKeyBytes);
    return credentials.address.hex;
  }

  /// Parses a 64-character hex private key (with or without `0x`) to address.
  static String addressFromPrivateKeyHex(String hexKey) {
    final String normalized = hexKey.startsWith('0x') || hexKey.startsWith('0X')
        ? hexKey.substring(2)
        : hexKey;
    if (normalized.length != 64) {
      throw ArgumentError('Private key must be 64 hex characters');
    }
    HEX.decode(normalized); // validate hex
    final EthPrivateKey credentials = EthPrivateKey.fromHex(normalized);
    return credentials.address.hex;
  }
}
