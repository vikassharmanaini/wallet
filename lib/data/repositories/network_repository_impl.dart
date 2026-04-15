import 'package:superweb3wallet/data/datasources/network_asset_loader.dart';
import 'package:superweb3wallet/data/datasources/preferences_storage.dart';
import 'package:superweb3wallet/data/models/chain_network.dart';
import 'package:superweb3wallet/domain/repositories/network_repository.dart';

/// Default [NetworkRepository] backed by assets + Hive preferences.
class NetworkRepositoryImpl implements NetworkRepository {
  /// Creates repository with bundled loader and [preferences].
  NetworkRepositoryImpl(this._loader, this._preferences);

  final NetworkAssetLoader _loader;
  final PreferencesStorage _preferences;

  List<ChainNetwork>? _cache;

  @override
  Future<List<ChainNetwork>> builtInNetworks() async {
    _cache ??= await _loader.loadDefaults();
    return _cache!;
  }

  @override
  Future<int> activeChainId() async {
    final int? stored = await _preferences.readActiveChainId();
    return stored ?? 1;
  }

  @override
  Future<void> setActiveChainId(int chainId) =>
      _preferences.saveActiveChainId(chainId);
}
