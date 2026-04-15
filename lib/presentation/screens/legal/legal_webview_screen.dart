import 'package:flutter/material.dart';
import 'package:superweb3wallet/l10n/app_localizations.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Displays Terms or Privacy content inside an in-app [WebView].
class LegalWebViewScreen extends StatefulWidget {
  /// Base path for legal pages.
  static const String routePath = '/legal';

  /// Named route identifier.
  static const String routeName = 'legal';

  /// Creates a legal web view for [initialUrl].
  const LegalWebViewScreen({super.key, required this.initialUrl});

  /// Fully qualified URL to load.
  final String initialUrl;

  @override
  State<LegalWebViewScreen> createState() => _LegalWebViewScreenState();
}

class _LegalWebViewScreenState extends State<LegalWebViewScreen> {
  late final WebViewController _controller;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) => setState(() => _loading = false),
        ),
      )
      ..loadRequest(Uri.parse(widget.initialUrl));
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: <Widget>[
          WebViewWidget(controller: _controller),
          if (_loading) Center(child: Text(l10n.legalLoading)),
        ],
      ),
    );
  }
}
