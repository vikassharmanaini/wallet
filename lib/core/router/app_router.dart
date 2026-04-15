import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/bootstrap/bootstrap_screen.dart';

/// Central [GoRouter] configuration for SuperWeb3Wallet.
class AppRouter {
  AppRouter._();

  /// Root [GoRouter] used by [MaterialApp.router].
  static final GoRouter router = GoRouter(
    initialLocation: BootstrapScreen.routePath,
    routes: <RouteBase>[
      GoRoute(
        path: BootstrapScreen.routePath,
        name: BootstrapScreen.routeName,
        builder: (BuildContext context, GoRouterState state) =>
            const BootstrapScreen(),
      ),
    ],
  );
}
