import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:superweb3wallet/l10n/app_localizations.dart';
import 'package:superweb3wallet/presentation/screens/legal/legal_webview_screen.dart';
import 'package:superweb3wallet/presentation/screens/onboarding/create_password_screen.dart';
import 'package:superweb3wallet/presentation/screens/onboarding/import_private_key_screen.dart';
import 'package:superweb3wallet/presentation/screens/onboarding/import_srp_screen.dart';

/// First-run choices: create wallet, import phrase, or import private key.
class OnboardingScreen extends StatelessWidget {
  /// Primary onboarding route.
  static const String routePath = '/onboarding';

  /// Named route identifier.
  static const String routeName = 'onboarding';

  /// Creates onboarding UI.
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 24),
              SizedBox(
                height: 180,
                child: Lottie.asset(
                  'assets/animations/onboarding.json',
                  repeat: true,
                  errorBuilder:
                      (BuildContext context, Object error, StackTrace? stack) {
                    return Icon(
                      Icons.account_balance_wallet,
                      size: 120,
                      color: theme.colorScheme.primary,
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              Text(
                l10n.appTitle,
                style: theme.textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () =>
                      context.push(CreatePasswordScreen.routePath),
                  child: Text(l10n.onboardingCreateWallet),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => context.push(ImportSrpScreen.routePath),
                  child: Text(l10n.onboardingImportSrp),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () =>
                      context.push(ImportPrivateKeyScreen.routePath),
                  child: Text(l10n.onboardingImportPk),
                ),
              ),
              const SizedBox(height: 24),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 16,
                children: <Widget>[
                  TextButton(
                    onPressed: () => context.push(
                      '${LegalWebViewScreen.routePath}?type=privacy',
                    ),
                    child: Text(l10n.onboardingPrivacyPolicy),
                  ),
                  TextButton(
                    onPressed: () => context.push(
                      '${LegalWebViewScreen.routePath}?type=terms',
                    ),
                    child: Text(l10n.onboardingTermsOfService),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
