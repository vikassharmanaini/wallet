import 'package:flutter/services.dart' show rootBundle;
import 'package:superweb3wallet/data/models/chain_network.dart';

/// Loads bundled network metadata from `assets/networks.json`.
class NetworkAssetLoader {
  /// Reads and parses the default network list shipped with the app.
  Future<List<ChainNetwork>> loadDefaults() async {
    final String raw =
        await rootBundle.loadString('assets/networks.json');
    return ChainNetwork.parseList(raw);
  }
}
