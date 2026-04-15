import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:superweb3wallet/l10n/app_localizations.dart';
import 'package:superweb3wallet/presentation/models/wallet_creation_args.dart';
import 'package:superweb3wallet/presentation/screens/onboarding/mnemonic_quiz_screen.dart';

/// Displays generated mnemonic with show/hide, copy warning, and confirmation.
class BackupPhraseScreen extends StatefulWidget {
  /// Route path for mnemonic backup.
  static const String routePath = '/create-wallet/phrase';

  /// Named route identifier.
  static const String routeName = 'backupPhrase';

  /// Creates backup UI; expects [WalletCreationArgs] via [GoRouter.extra].
  const BackupPhraseScreen({super.key});

  @override
  State<BackupPhraseScreen> createState() => _BackupPhraseScreenState();
}

class _BackupPhraseScreenState extends State<BackupPhraseScreen> {
  bool _hidden = true;
  bool _ack = false;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final WalletCreationArgs args =
        GoRouterState.of(context).extra! as WalletCreationArgs;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.backupTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(l10n.backupSubtitle),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                TextButton(
                  onPressed: () => setState(() => _hidden = !_hidden),
                  child: Text(_hidden ? l10n.backupToggleShow : l10n.backupToggleHide),
                ),
                TextButton(
                  onPressed: () async {
                    final bool? ok = await showDialog<bool>(
                      context: context,
                      builder: (BuildContext ctx) => AlertDialog(
                        title: Text(l10n.backupCopyUnsafeTitle),
                        content: Text(l10n.backupCopyUnsafeBody),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, false),
                            child: Text(l10n.commonCancel),
                          ),
                          FilledButton(
                            onPressed: () => Navigator.pop(ctx, true),
                            child: Text(l10n.commonOk),
                          ),
                        ],
                      ),
                    );
                    if (ok == true) {
                      await Clipboard.setData(
                        ClipboardData(text: args.mnemonicWords.join(' ')),
                      );
                    }
                  },
                  child: Text(l10n.backupCopy),
                ),
              ],
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 2.4,
                ),
                itemCount: args.mnemonicWords.length,
                itemBuilder: (BuildContext context, int index) {
                  final String word = args.mnemonicWords[index];
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    ),
                    child: Center(
                      child: Text(
                        _hidden ? '••••' : '${index + 1}. $word',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ),
            CheckboxListTile(
              value: _ack,
              onChanged: (bool? v) => setState(() => _ack = v ?? false),
              title: Text(l10n.backupWroteDown),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _ack
                    ? () => context.push(
                          MnemonicQuizScreen.routePath,
                          extra: args,
                        )
                    : null,
                child: Text(l10n.backupContinue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
