import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:superweb3wallet/domain/repositories/wallet_repository.dart';
import 'package:superweb3wallet/l10n/app_localizations.dart';
import 'package:superweb3wallet/presentation/screens/home/wallet_home_screen.dart';
import 'package:superweb3wallet/presentation/screens/onboarding/onboarding_screen.dart';

/// Chooses between onboarding and home based on persisted wallet state.
class SplashScreen extends StatefulWidget {
  /// Route path for cold start.
  static const String routePath = '/splash';

  /// Named route for tests and deep links.
  static const String routeName = 'splash';

  /// Creates splash gate.
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _route());
  }

  Future<void> _route() async {
    final WalletRepository repo = context.read<WalletRepository>();
    final bool hasWallet = await repo.hasWallet();
    if (!mounted) {
      return;
    }
    if (hasWallet) {
      context.go(WalletHomeScreen.routePath);
    } else {
      context.go(OnboardingScreen.routePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return Scaffold(
      body: Center(child: Text(l10n.splashLoading)),
    );
  }
}
