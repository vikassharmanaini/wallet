import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:superweb3wallet/core/security/local_auth_service.dart';
import 'package:superweb3wallet/domain/repositories/wallet_repository.dart';
import 'package:superweb3wallet/l10n/app_localizations.dart';
import 'package:superweb3wallet/presentation/screens/home/wallet_home_screen.dart';
import 'package:superweb3wallet/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:superweb3wallet/presentation/security/app_lock_controller.dart';

/// Full-screen biometric gate shown when the app auto-locks.
class LockScreen extends StatelessWidget {
  /// Route path for the lock gate.
  static const String routePath = '/lock';

  /// Named route identifier.
  static const String routeName = 'lock';

  /// Creates the lock UI.
  const LockScreen({super.key});

  Future<void> _unlock(BuildContext context) async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final LocalAuthService auth = context.read<LocalAuthService>();
    final AppLockController lock = context.read<AppLockController>();
    final WalletRepository repo = context.read<WalletRepository>();
    final bool ok = await auth.authenticate(localizedReason: l10n.lockReason);
    if (!context.mounted || !ok) {
      return;
    }
    lock.unlock();
    final bool hasWallet = await repo.hasWallet();
    if (!context.mounted) {
      return;
    }
    context.go(
      hasWallet ? WalletHomeScreen.routePath : OnboardingScreen.routePath,
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          ColoredBox(
            color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.92),
          ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 360),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        l10n.lockTitle,
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        l10n.lockSubtitle,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      FilledButton(
                        onPressed: () => _unlock(context),
                        child: Text(l10n.lockUnlock),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
