/// Arguments passed between onboarding routes (memory-only, never logged).
class WalletCreationArgs {
  /// Creates in-memory arguments for backup and quiz steps.
  const WalletCreationArgs({
    required this.password,
    required this.mnemonicWords,
  });

  /// User password used only to encrypt secrets before persistence.
  final String password;

  /// BIP39 mnemonic split into words.
  final List<String> mnemonicWords;
}
