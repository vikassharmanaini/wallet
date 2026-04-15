import 'package:flutter/material.dart';
import 'package:superweb3wallet/l10n/app_localizations.dart';

/// Token swap entry point (quotes + execution to be wired to 1inch).
class SwapScreen extends StatelessWidget {
  /// Route path for swap.
  static const String routePath = '/swap';

  /// Named route identifier.
  static const String routeName = 'swap';

  /// Creates swap UI shell.
  const SwapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.swapTitle)),
      body: Center(child: Text(l10n.swapTitle)),
    );
  }
}
