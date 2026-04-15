import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as enc;
import 'package:pointycastle/export.dart' hide State;

/// AES-256-GCM envelope encryption with PBKDF2-derived keys for wallet blobs.
class CryptoVault {
  /// Encrypts [plaintext] using [password] and a random [salt] (returned).
  static ({String ciphertextBase64, String saltBase64}) encrypt({
    required String plaintext,
    required String password,
    Uint8List? salt,
  }) {
    final Uint8List saltBytes = salt ?? _randomBytes(16);
    final Uint8List derived = _pbkdf2(
      utf8.encode(password),
      saltBytes,
    );
    final enc.Key key = enc.Key(Uint8List.fromList(derived));
    final Uint8List ivBytes = _randomBytes(12);
    final enc.IV iv = enc.IV(ivBytes);
    final enc.Encrypter encrypter = enc.Encrypter(
      enc.AES(key, mode: enc.AESMode.gcm, padding: null),
    );
    final enc.Encrypted encrypted = encrypter.encrypt(plaintext, iv: iv);
    final Uint8List packed = Uint8List.fromList(<int>[
      ...ivBytes,
      ...encrypted.bytes,
    ]);
    return (
      ciphertextBase64: base64Encode(packed),
      saltBase64: base64Encode(saltBytes),
    );
  }

  /// Decrypts a payload produced by [encrypt].
  static String decrypt({
    required String ciphertextBase64,
    required String saltBase64,
    required String password,
  }) {
    final Uint8List packed = base64Decode(ciphertextBase64);
    final Uint8List ivBytes = Uint8List.sublistView(packed, 0, 12);
    final Uint8List cipherBytes = Uint8List.sublistView(packed, 12);
    final Uint8List saltBytes = base64Decode(saltBase64);
    final Uint8List derived = _pbkdf2(utf8.encode(password), saltBytes);
    final enc.Key key = enc.Key(Uint8List.fromList(derived));
    final enc.IV iv = enc.IV(ivBytes);
    final enc.Encrypter encrypter = enc.Encrypter(
      enc.AES(key, mode: enc.AESMode.gcm, padding: null),
    );
    final enc.Encrypted encrypted = enc.Encrypted(cipherBytes);
    return encrypter.decrypt(encrypted, iv: iv);
  }

  static Uint8List _pbkdf2(List<int> password, Uint8List salt) {
    final HMac mac = HMac(SHA256Digest(), 64);
    final PBKDF2KeyDerivator derivator = PBKDF2KeyDerivator(mac);
    derivator.init(Pbkdf2Parameters(salt, 200000, 32));
    return derivator.process(Uint8List.fromList(password));
  }

  static Uint8List _randomBytes(int length) {
    final Random random = Random.secure();
    return Uint8List.fromList(
      List<int>.generate(length, (_) => random.nextInt(256)),
    );
  }
}
