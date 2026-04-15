/// Discriminator for import flows that require a password before persistence.
sealed class ImportKind {
  const ImportKind();
}

/// Import using a validated BIP39 mnemonic string.
final class ImportKindMnemonic extends ImportKind {
  /// Wraps a normalized mnemonic (single spaces between words).
  const ImportKindMnemonic(this.mnemonic);

  /// Full mnemonic phrase.
  final String mnemonic;
}

/// Import using a 64-character hex private key (no 0x prefix stored).
final class ImportKindPrivateKey extends ImportKind {
  /// Wraps a normalized 64-hex-character private key.
  const ImportKindPrivateKey(this.hexKey);

  /// Private key hex without 0x prefix.
  final String hexKey;
}
