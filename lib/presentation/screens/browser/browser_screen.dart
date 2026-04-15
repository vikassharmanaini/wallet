import 'package:flutter/material.dart';
import 'package:superweb3wallet/l10n/app_localizations.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// In-app browser shell (EIP-1193 injection to be added in a follow-up).
class BrowserScreen extends StatefulWidget {
  /// Route path for browser.
  static const String routePath = '/browser';

  /// Named route identifier.
  static const String routeName = 'browser';

  /// Optional initial URL from navigation extra.
  const BrowserScreen({super.key, this.initialUrl});

  /// Starting URL when provided.
  final String? initialUrl;

  @override
  State<BrowserScreen> createState() => _BrowserScreenState();
}

class _BrowserScreenState extends State<BrowserScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    final String start =
        widget.initialUrl ?? 'https://ethereum.org';
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(start));
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.browserTitle)),
      body: WebViewWidget(controller: _controller),
    );
  }
}
