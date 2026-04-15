import 'package:superweb3wallet/domain/repositories/network_repository.dart';

/// Aggregates native token balance and simple USD estimate for the portfolio header.
class FetchPortfolioBalanceUseCase {
  /// Creates use case with network context.
  const FetchPortfolioBalanceUseCase(this._networks);

  final NetworkRepository _networks;

  /// Returns a placeholder total while price oracles are wired (Phase 2+).
  Future<double> call({required String address}) async {
    if (address.isEmpty) {
      return 0;
    }
    await _networks.activeChainId();
    return 0;
  }
}
