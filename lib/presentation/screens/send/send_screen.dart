import 'package:flutter/material.dart';
import 'package:superweb3wallet/l10n/app_localizations.dart';

/// Multi-step send flow (asset, recipient, amount, gas, review).
class SendScreen extends StatelessWidget {
  /// Route path for send flow.
  static const String routePath = '/send';

  /// Named route identifier.
  static const String routeName = 'send';

  /// Creates send placeholder UI.
  const SendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.sendTitle)),
      body: Center(child: Text(l10n.sendTitle)),
    );
  }
}
