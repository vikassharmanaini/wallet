import 'package:superweb3wallet/domain/repositories/wallet_repository.dart';

/// Lightweight fake for widget tests (no platform secure storage).
class FakeWalletRepository implements WalletRepository {
  /// Creates fake with optional initial state.
  FakeWalletRepository({this.hasWalletValue = false, this.storedAddress});

  /// Returned by [hasWallet].
  bool hasWalletValue;

  /// Optional address returned by [primaryAddress].
  String? storedAddress;

  @override
  Future<bool> hasWallet() async => hasWalletValue;

  @override
  Future<void> clearWallet() async {
    hasWalletValue = false;
    storedAddress = null;
  }

  @override
  Future<void> importMnemonic({
    required String mnemonic,
    required String password,
  }) async {
    hasWalletValue = true;
    storedAddress = '0xabc';
  }

  @override
  Future<void> importPrivateKey({
    required String hexPrivateKey,
    required String password,
  }) async {
    hasWalletValue = true;
    storedAddress = '0xdef';
  }

  @override
  Future<String?> primaryAddress() async => storedAddress;

  @override
  Future<void> saveNewWallet({
    required String mnemonic,
    required String password,
  }) async {
    hasWalletValue = true;
    storedAddress = '0x111';
  }
}
