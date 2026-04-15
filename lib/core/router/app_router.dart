import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:superweb3wallet/presentation/screens/accounts/accounts_screen.dart';
import 'package:superweb3wallet/presentation/screens/home/wallet_home_screen.dart';
import 'package:superweb3wallet/presentation/screens/receive/receive_screen.dart';
import 'package:superweb3wallet/presentation/screens/send/send_screen.dart';
import 'package:superweb3wallet/presentation/screens/legal/legal_webview_screen.dart';
import 'package:superweb3wallet/presentation/screens/onboarding/backup_phrase_screen.dart';
import 'package:superweb3wallet/presentation/screens/onboarding/create_password_screen.dart';
import 'package:superweb3wallet/presentation/screens/onboarding/import_password_screen.dart';
import 'package:superweb3wallet/presentation/screens/onboarding/import_private_key_screen.dart';
import 'package:superweb3wallet/presentation/screens/onboarding/import_srp_screen.dart';
import 'package:superweb3wallet/presentation/screens/onboarding/mnemonic_quiz_screen.dart';
import 'package:superweb3wallet/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:superweb3wallet/presentation/screens/security/lock_screen.dart';
import 'package:superweb3wallet/presentation/screens/splash/splash_screen.dart';
import 'package:superweb3wallet/presentation/security/app_lock_controller.dart';

/// Central [GoRouter] configuration for SuperWeb3Wallet.
class AppRouter {
  AppRouter._();

  /// Builds the application router graph.
  static GoRouter createRouter({required AppLockController appLock}) {
    return GoRouter(
      refreshListenable: appLock,
      redirect: (BuildContext context, GoRouterState state) {
        if (appLock.locked &&
            state.matchedLocation != LockScreen.routePath) {
          return LockScreen.routePath;
        }
        return null;
      },
      initialLocation: SplashScreen.routePath,
      routes: <RouteBase>[
        GoRoute(
          path: SplashScreen.routePath,
          name: SplashScreen.routeName,
          builder: (BuildContext context, GoRouterState state) =>
              const SplashScreen(),
        ),
        GoRoute(
          path: OnboardingScreen.routePath,
          name: OnboardingScreen.routeName,
          builder: (BuildContext context, GoRouterState state) =>
              const OnboardingScreen(),
        ),
        GoRoute(
          path: CreatePasswordScreen.routePath,
          name: CreatePasswordScreen.routeName,
          builder: (BuildContext context, GoRouterState state) =>
              const CreatePasswordScreen(),
        ),
        GoRoute(
          path: BackupPhraseScreen.routePath,
          name: BackupPhraseScreen.routeName,
          builder: (BuildContext context, GoRouterState state) =>
              const BackupPhraseScreen(),
        ),
        GoRoute(
          path: MnemonicQuizScreen.routePath,
          name: MnemonicQuizScreen.routeName,
          builder: (BuildContext context, GoRouterState state) =>
              const MnemonicQuizScreen(),
        ),
        GoRoute(
          path: ImportSrpScreen.routePath,
          name: ImportSrpScreen.routeName,
          builder: (BuildContext context, GoRouterState state) =>
              const ImportSrpScreen(),
        ),
        GoRoute(
          path: ImportPrivateKeyScreen.routePath,
          name: ImportPrivateKeyScreen.routeName,
          builder: (BuildContext context, GoRouterState state) =>
              const ImportPrivateKeyScreen(),
        ),
        GoRoute(
          path: ImportPasswordScreen.routePath,
          name: ImportPasswordScreen.routeName,
          builder: (BuildContext context, GoRouterState state) =>
              const ImportPasswordScreen(),
        ),
        GoRoute(
          path: WalletHomeScreen.routePath,
          name: WalletHomeScreen.routeName,
          builder: (BuildContext context, GoRouterState state) =>
              const WalletHomeScreen(),
        ),
        GoRoute(
          path: SendScreen.routePath,
          name: SendScreen.routeName,
          builder: (BuildContext context, GoRouterState state) =>
              const SendScreen(),
        ),
        GoRoute(
          path: ReceiveScreen.routePath,
          name: ReceiveScreen.routeName,
          builder: (BuildContext context, GoRouterState state) =>
              const ReceiveScreen(),
        ),
        GoRoute(
          path: AccountsScreen.routePath,
          name: AccountsScreen.routeName,
          builder: (BuildContext context, GoRouterState state) =>
              const AccountsScreen(),
        ),
        GoRoute(
          path: LegalWebViewScreen.routePath,
          name: LegalWebViewScreen.routeName,
          builder: (BuildContext context, GoRouterState state) {
            final String? type = state.uri.queryParameters['type'];
            final String url = type == 'terms'
                ? 'https://policies.google.com/terms?hl=en'
                : 'https://policies.google.com/privacy?hl=en';
            return LegalWebViewScreen(initialUrl: url);
          },
        ),
        GoRoute(
          path: LockScreen.routePath,
          name: LockScreen.routeName,
          builder: (BuildContext context, GoRouterState state) =>
              const LockScreen(),
        ),
      ],
    );
  }
}
