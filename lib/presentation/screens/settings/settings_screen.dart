import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:superweb3wallet/l10n/app_localizations.dart';
import 'package:superweb3wallet/presentation/blocs/theme/theme_cubit.dart';
import 'package:superweb3wallet/presentation/screens/legal/legal_webview_screen.dart';

/// Settings hub (theme, legal, notification placeholders).
class SettingsScreen extends StatelessWidget {
  /// Route path for settings.
  static const String routePath = '/settings';

  /// Named route identifier.
  static const String routeName = 'settings';

  /// Creates settings UI.
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final ThemeCubit theme = context.read<ThemeCubit>();
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        children: <Widget>[
          ListTile(title: Text(l10n.settingsTheme)),
          ListTile(
            title: Text(l10n.settingsThemeSystem),
            onTap: () => theme.setTheme(ThemeMode.system),
          ),
          ListTile(
            title: Text(l10n.settingsThemeLight),
            onTap: () => theme.setTheme(ThemeMode.light),
          ),
          ListTile(
            title: Text(l10n.settingsThemeDark),
            onTap: () => theme.setTheme(ThemeMode.dark),
          ),
          const Divider(),
          ListTile(
            title: Text(l10n.onboardingPrivacyPolicy),
            onTap: () => context.push(
              '${LegalWebViewScreen.routePath}?type=privacy',
            ),
          ),
          ListTile(
            title: Text(l10n.onboardingTermsOfService),
            onTap: () => context.push(
              '${LegalWebViewScreen.routePath}?type=terms',
            ),
          ),
          const Divider(),
          ListTile(
            title: Text(l10n.settingsNotifications),
            subtitle: Text(l10n.settingsNotificationsStub),
          ),
        ],
      ),
    );
  }
}
