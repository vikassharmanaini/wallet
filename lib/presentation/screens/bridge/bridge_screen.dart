import 'package:flutter/material.dart';
import 'package:superweb3wallet/l10n/app_localizations.dart';

/// Cross-chain bridge entry point (LI.FI / Socket integration placeholder).
class BridgeScreen extends StatelessWidget {
  /// Route path for bridge.
  static const String routePath = '/bridge';

  /// Named route identifier.
  static const String routeName = 'bridge';

  /// Creates bridge UI shell.
  const BridgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.bridgeTitle)),
      body: Center(child: Text(l10n.bridgeTitle)),
    );
  }
}
