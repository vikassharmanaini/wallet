import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superweb3wallet/domain/repositories/wallet_repository.dart';
import 'package:superweb3wallet/l10n/app_localizations.dart';

/// Lists derived/imported accounts (multi-account management).
class AccountsScreen extends StatelessWidget {
  /// Route path for accounts manager.
  static const String routePath = '/accounts';

  /// Named route identifier.
  static const String routeName = 'accounts';

  /// Creates accounts UI.
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final WalletRepository repo = context.read<WalletRepository>();
    return Scaffold(
      appBar: AppBar(title: Text(l10n.accountsTitle)),
      body: FutureBuilder<String?>(
        future: repo.primaryAddress(),
        builder: (BuildContext context, AsyncSnapshot<String?> snap) {
          final String? addr = snap.data;
          return ListView(
            children: <Widget>[
              ListTile(
                title: Text(l10n.homeAccountName),
                subtitle: Text(addr ?? '—'),
              ),
            ],
          );
        },
      ),
    );
  }
}
