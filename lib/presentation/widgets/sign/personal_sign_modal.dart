import 'package:flutter/material.dart';
import 'package:superweb3wallet/l10n/app_localizations.dart';

/// Bottom-sheet style UI for `personal_sign` requests.
class PersonalSignModal extends StatelessWidget {
  /// Creates a read-only preview of a signing request.
  const PersonalSignModal({super.key, required this.message});

  /// Raw message bytes or UTF-8 text depending on caller.
  final String message;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l10n.signPersonalTitle),
      content: SingleChildScrollView(child: Text(message)),
      actions: <Widget>[
        TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.commonCancel)),
        FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n.commonOk)),
      ],
    );
  }
}
