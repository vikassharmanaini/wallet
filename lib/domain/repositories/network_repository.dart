import 'package:superweb3wallet/data/models/chain_network.dart';

/// Access to configured EVM networks and the user's active selection.
abstract class NetworkRepository {
  /// Built-in networks bundled with the app.
  Future<List<ChainNetwork>> builtInNetworks();

  /// Currently selected chain id (EIP-155).
  Future<int> activeChainId();

  /// Persists the active chain id.
  Future<void> setActiveChainId(int chainId);
}
