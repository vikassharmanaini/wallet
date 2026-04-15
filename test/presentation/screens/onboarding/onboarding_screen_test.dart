import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:superweb3wallet/l10n/app_localizations.dart';
import 'package:superweb3wallet/presentation/screens/onboarding/onboarding_screen.dart';

void main() {
  testWidgets('OnboardingScreen shows primary actions', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: <LocalizationsDelegate<dynamic>>[
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: OnboardingScreen(),
      ),
    );
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Create a New Wallet'), findsOneWidget);
    expect(find.text('Import Using Secret Recovery Phrase'), findsOneWidget);
    expect(find.text('Import Using Private Key'), findsOneWidget);
  });
}
