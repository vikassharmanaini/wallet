import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:superweb3wallet/data/models/chain_network.dart';
import 'package:superweb3wallet/domain/repositories/network_repository.dart';
import 'package:superweb3wallet/domain/repositories/wallet_repository.dart';
import 'package:superweb3wallet/l10n/app_localizations.dart';

/// Receive funds screen with QR code and safety reminder.
class ReceiveScreen extends StatelessWidget {
  /// Route path for receive flow.
  static const String routePath = '/receive';

  /// Named route identifier.
  static const String routeName = 'receive';

  /// Creates receive UI.
  const ReceiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final WalletRepository wallet = context.read<WalletRepository>();
    final NetworkRepository networks = context.read<NetworkRepository>();
    return Scaffold(
      appBar: AppBar(title: Text(l10n.receiveTitle)),
      body: FutureBuilder<(String?, ChainNetwork?)>(
        future: _load(wallet, networks),
        builder: (BuildContext context, AsyncSnapshot<(String?, ChainNetwork?)> snap) {
          final (String? address, ChainNetwork? net) =
              snap.data ?? (null, null);
          if (address == null || net == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Text(
                  l10n.receiveHint(net.symbol, net.name),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                QrImageView(data: address, size: 220),
                const SizedBox(height: 16),
                SelectableText(address),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: address));
                  },
                  child: Text(l10n.backupCopy),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  static Future<(String?, ChainNetwork?)> _load(
    WalletRepository wallet,
    NetworkRepository networks,
  ) async {
    final String? address = await wallet.primaryAddress();
    final int id = await networks.activeChainId();
    final List<ChainNetwork> all = await networks.builtInNetworks();
    final ChainNetwork net = all.firstWhere(
      (ChainNetwork n) => n.chainId == id,
      orElse: () => all.first,
    );
    return (address, net);
  }
}
