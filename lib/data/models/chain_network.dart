import 'dart:convert';

/// JSON definition of an EVM chain used by the wallet UI and RPC client.
class ChainNetwork {
  /// Parses a single network entry from JSON.
  ChainNetwork({
    required this.name,
    required this.chainId,
    required this.rpcUrl,
    required this.symbol,
    required this.explorer,
  });

  /// Human-readable network label.
  final String name;

  /// EIP-155 chain id.
  final int chainId;

  /// HTTPS JSON-RPC endpoint (may be user-supplied for custom nets).
  final String rpcUrl;

  /// Native gas token symbol.
  final String symbol;

  /// Default block explorer base URL.
  final String explorer;

  /// Parses a list of networks from the bundled `assets/networks.json`.
  static List<ChainNetwork> parseList(String json) {
    final List<dynamic> data = jsonDecode(json) as List<dynamic>;
    return data
        .cast<Map<String, dynamic>>()
        .map(ChainNetwork.fromJson)
        .toList(growable: false);
  }

  /// Parses one JSON object.
  factory ChainNetwork.fromJson(Map<String, dynamic> json) {
    return ChainNetwork(
      name: json['name'] as String,
      chainId: (json['chainId'] as num).toInt(),
      rpcUrl: json['rpcUrl'] as String,
      symbol: json['symbol'] as String,
      explorer: json['explorer'] as String,
    );
  }
}
