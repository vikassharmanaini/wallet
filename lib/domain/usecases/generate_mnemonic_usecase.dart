import 'package:bip39/bip39.dart' as bip39;

/// Generates a new BIP39 mnemonic phrase (12 words) for wallet creation.
class GenerateMnemonicUseCase {
  /// Creates use case instance.
  const GenerateMnemonicUseCase();

  /// Returns a space-separated 12-word English mnemonic.
  String call() => bip39.generateMnemonic();
}
