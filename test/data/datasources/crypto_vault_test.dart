import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:superweb3wallet/data/datasources/crypto_vault.dart';

void main() {
  test('CryptoVault roundtrip preserves plaintext', () {
    const String password = 'Str0ng!Pass';
    final ({String ciphertextBase64, String saltBase64}) enc =
        CryptoVault.encrypt(
      plaintext: 'abandon abandon abandon',
      password: password,
      salt: Uint8List(16),
    );
    final String out = CryptoVault.decrypt(
      ciphertextBase64: enc.ciphertextBase64,
      saltBase64: enc.saltBase64,
      password: password,
    );
    expect(out, 'abandon abandon abandon');
  });
}
