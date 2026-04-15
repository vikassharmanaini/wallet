import 'package:flutter/material.dart';
import 'package:superweb3wallet/data/models/chain_network.dart';
import 'package:superweb3wallet/domain/repositories/network_repository.dart';
import 'package:superweb3wallet/l10n/app_localizations.dart';

/// Bottom sheet listing built-in networks for quick switching.
Future<void> showNetworkSelectorSheet({
  required BuildContext context,
  required NetworkRepository networks,
}) async {
  final AppLocalizations l10n = AppLocalizations.of(context);
  final List<ChainNetwork> items = await networks.builtInNetworks();
  final int active = await networks.activeChainId();
  if (!context.mounted) {
    return;
  }
  await showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (BuildContext ctx) {
      return SafeArea(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                l10n.networkPickerTitle,
                style: Theme.of(ctx).textTheme.titleMedium,
              ),
            ),
            for (final ChainNetwork net in items)
              ListTile(
                title: Text(net.name),
                subtitle: Text('${net.symbol} · ${net.chainId}'),
                trailing: net.chainId == active ? const Icon(Icons.check) : null,
                onTap: () async {
                  await networks.setActiveChainId(net.chainId);
                  if (ctx.mounted) {
                    Navigator.pop(ctx);
                  }
                },
              ),
          ],
        ),
      );
    },
  );
}
