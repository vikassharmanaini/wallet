import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:superweb3wallet/domain/repositories/wallet_repository.dart';
import 'package:superweb3wallet/l10n/app_localizations.dart';
import 'package:superweb3wallet/presentation/models/wallet_creation_args.dart';
import 'package:superweb3wallet/presentation/screens/home/wallet_home_screen.dart';

/// Verifies the user wrote down specific mnemonic words before unlocking home.
class MnemonicQuizScreen extends StatefulWidget {
  /// Route path for mnemonic verification.
  static const String routePath = '/create-wallet/quiz';

  /// Named route identifier.
  static const String routeName = 'mnemonicQuiz';

  /// Creates quiz UI; expects [WalletCreationArgs] via [GoRouter.extra].
  const MnemonicQuizScreen({super.key});

  @override
  State<MnemonicQuizScreen> createState() => _MnemonicQuizScreenState();
}

class _MnemonicQuizScreenState extends State<MnemonicQuizScreen> {
  late final List<int> _indices;
  final Map<int, TextEditingController> _controllers = <int, TextEditingController>{};

  @override
  void initState() {
    super.initState();
    _indices = <int>[2, 6, 10];
    for (final int i in _indices) {
      _controllers[i] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (final TextEditingController c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _submit(WalletCreationArgs args) async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    for (final int i in _indices) {
      final String expected = args.mnemonicWords[i].toLowerCase();
      final String actual = _controllers[i]!.text.trim().toLowerCase();
      if (actual != expected) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.quizIncorrect)),
        );
        return;
      }
    }
    final WalletRepository repo = context.read<WalletRepository>();
    await repo.saveNewWallet(
      mnemonic: args.mnemonicWords.join(' '),
      password: args.password,
    );
    if (!mounted) {
      return;
    }
    context.go(WalletHomeScreen.routePath);
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final WalletCreationArgs args =
        GoRouterState.of(context).extra! as WalletCreationArgs;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.quizTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            Text(l10n.quizSubtitle),
            const SizedBox(height: 16),
            for (final int i in _indices) ...<Widget>[
              TextField(
                controller: _controllers[i],
                decoration: InputDecoration(
                  labelText: l10n.quizWordLabel(i + 1),
                ),
              ),
              const SizedBox(height: 12),
            ],
            FilledButton(
              onPressed: () => _submit(args),
              child: Text(l10n.quizContinue),
            ),
          ],
        ),
      ),
    );
  }
}
