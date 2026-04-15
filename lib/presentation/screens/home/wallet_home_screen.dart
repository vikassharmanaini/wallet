import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superweb3wallet/domain/repositories/wallet_repository.dart';
import 'package:superweb3wallet/l10n/app_localizations.dart';

/// Primary wallet dashboard after onboarding completes.
class WalletHomeScreen extends StatelessWidget {
  /// Route path for wallet home.
  static const String routePath = '/home';

  /// Named route identifier.
  static const String routeName = 'home';

  /// Creates wallet home UI.
  const WalletHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final WalletRepository repo = context.read<WalletRepository>();
    return Scaffold(
      appBar: AppBar(title: Text(l10n.homeTitle)),
      body: FutureBuilder<String?>(
        future: repo.primaryAddress(),
        builder: (BuildContext context, AsyncSnapshot<String?> snap) {
          final String? addr = snap.data;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(l10n.homeAddress, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                SelectableText(addr ?? '—'),
              ],
            ),
          );
        },
      ),
    );
  }
}
