import 'package:flutter/material.dart';
import 'package:superweb3wallet/l10n/app_localizations.dart';

/// Fiat on-ramp entry point (MoonPay/Transak WebViews to be integrated).
class BuyScreen extends StatelessWidget {
  /// Route path for buy crypto.
  static const String routePath = '/buy';

  /// Named route identifier.
  static const String routeName = 'buy';

  /// Creates buy UI shell.
  const BuyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.buyTitle)),
      body: Center(child: Text(l10n.buyTitle)),
    );
  }
}
