import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hex/hex.dart';
import 'package:superweb3wallet/l10n/app_localizations.dart';
import 'package:superweb3wallet/presentation/models/import_kind.dart';
import 'package:superweb3wallet/presentation/screens/onboarding/import_password_screen.dart';

/// Imports a wallet from a 64-character hex private key.
class ImportPrivateKeyScreen extends StatefulWidget {
  /// Route path for private key import.
  static const String routePath = '/import/pk';

  /// Named route identifier.
  static const String routeName = 'importPk';

  /// Creates private key import UI.
  const ImportPrivateKeyScreen({super.key});

  @override
  State<ImportPrivateKeyScreen> createState() => _ImportPrivateKeyScreenState();
}

class _ImportPrivateKeyScreenState extends State<ImportPrivateKeyScreen> {
  final TextEditingController _key = TextEditingController();

  @override
  void dispose() {
    _key.dispose();
    super.dispose();
  }

  bool _validHex(String normalized) {
    if (normalized.length != 64) {
      return false;
    }
    try {
      HEX.decode(normalized);
      return true;
    } catch (_) {
      return false;
    }
  }

  void _continue(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    String hex = _key.text.trim();
    if (hex.startsWith('0x') || hex.startsWith('0X')) {
      hex = hex.substring(2);
    }
    if (!_validHex(hex)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.importPkInvalid)),
      );
      return;
    }
    context.push(
      ImportPasswordScreen.routePath,
      extra: ImportKindPrivateKey(hex),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.importPkTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: _key,
              decoration: InputDecoration(labelText: l10n.importPkHint),
              minLines: 1,
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => _continue(context),
              child: Text(l10n.importPkContinue),
            ),
          ],
        ),
      ),
    );
  }
}
