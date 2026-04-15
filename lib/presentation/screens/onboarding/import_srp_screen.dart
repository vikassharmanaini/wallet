import 'package:bip39/bip39.dart' as bip39;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:superweb3wallet/l10n/app_localizations.dart';
import 'package:superweb3wallet/presentation/models/import_kind.dart';
import 'package:superweb3wallet/presentation/screens/onboarding/import_password_screen.dart';

/// Imports a wallet using a 12- or 24-word recovery phrase.
class ImportSrpScreen extends StatefulWidget {
  /// Route path for mnemonic import.
  static const String routePath = '/import/srp';

  /// Named route identifier.
  static const String routeName = 'importSrp';

  /// Creates import UI.
  const ImportSrpScreen({super.key});

  @override
  State<ImportSrpScreen> createState() => _ImportSrpScreenState();
}

class _ImportSrpScreenState extends State<ImportSrpScreen> {
  final TextEditingController _paste = TextEditingController();
  bool _wordMode = false;
  final List<TextEditingController> _wordControllers =
      List<TextEditingController>.generate(
    12,
    (_) => TextEditingController(),
  );

  @override
  void dispose() {
    _paste.dispose();
    for (final TextEditingController c in _wordControllers) {
      c.dispose();
    }
    super.dispose();
  }

  String _joinedPhrase() {
    if (_wordMode) {
      return _wordControllers
          .map((TextEditingController c) => c.text.trim())
          .where((String w) => w.isNotEmpty)
          .join(' ');
    }
    return _paste.text.trim().split(RegExp(r'\s+')).join(' ');
  }

  void _continue(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final String phrase = _joinedPhrase();
    if (!bip39.validateMnemonic(phrase)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.importSrpInvalid)),
      );
      return;
    }
    context.push(
      ImportPasswordScreen.routePath,
      extra: ImportKindMnemonic(phrase),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.importSrpTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                ChoiceChip(
                  label: Text(l10n.importSrpPasteMode),
                  selected: !_wordMode,
                  onSelected: (_) => setState(() => _wordMode = false),
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: Text(l10n.importSrpWordsMode),
                  selected: _wordMode,
                  onSelected: (_) => setState(() => _wordMode = true),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (!_wordMode)
              TextField(
                controller: _paste,
                minLines: 2,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: l10n.importSrpPaste,
                ),
              )
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 2.2,
                ),
                itemCount: _wordControllers.length,
                itemBuilder: (BuildContext context, int index) {
                  return TextField(
                    controller: _wordControllers[index],
                    decoration: InputDecoration(
                      labelText: '${index + 1}',
                    ),
                  );
                },
              ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => _continue(context),
              child: Text(l10n.importSrpContinue),
            ),
          ],
        ),
      ),
    );
  }
}
