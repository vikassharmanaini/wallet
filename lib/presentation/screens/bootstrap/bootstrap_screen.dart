import 'package:flutter/material.dart';
import 'package:superweb3wallet/l10n/app_localizations.dart';

/// Temporary shell screen proving localization and routing work.
class BootstrapScreen extends StatelessWidget {
  /// Route path for the bootstrap placeholder.
  static const String routePath = '/';

  /// Named route identifier for deep links and tests.
  static const String routeName = 'bootstrap';

  /// Creates the bootstrap placeholder screen.
  const BootstrapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: Center(child: Text(l10n.bootstrapReady)),
    );
  }
}
