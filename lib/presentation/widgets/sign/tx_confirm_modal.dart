import 'package:flutter/material.dart';
import 'package:superweb3wallet/l10n/app_localizations.dart';

/// High-level confirmation UI for `eth_sendTransaction` requests.
class TxConfirmModal extends StatelessWidget {
  /// Creates a transaction summary dialog.
  const TxConfirmModal({
    super.key,
    required this.to,
    required this.valueWei,
  });

  /// Recipient address or contract.
  final String to;

  /// Value in wei as decimal string.
  final String valueWei;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l10n.signTxTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('To: $to'),
          Text('Value (wei): $valueWei'),
        ],
      ),
      actions: <Widget>[
        TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.commonCancel)),
        FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n.commonOk)),
      ],
    );
  }
}
