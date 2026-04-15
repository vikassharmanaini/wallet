import 'package:flutter/material.dart';

/// Centralized SuperWeb3Wallet design tokens and [ThemeData] factories.
abstract final class AppTheme {
  /// MetaMask-inspired primary blue.
  static const Color primaryBlue = Color(0xFF037DD6);

  /// MetaMask-inspired secondary orange.
  static const Color secondaryOrange = Color(0xFFF6851B);

  /// Success green for positive balances and confirmations.
  static const Color successGreen = Color(0xFF28A745);

  /// Warning amber for cautions.
  static const Color warningAmber = Color(0xFFFFC107);

  /// Danger red for destructive actions and errors.
  static const Color dangerRed = Color(0xFFD73A49);

  /// Light scaffold background.
  static const Color lightBackground = Color(0xFFFFFFFF);

  /// Light surface cards.
  static const Color lightSurface = Color(0xFFF2F4F6);

  /// Dark scaffold background.
  static const Color darkBackground = Color(0xFF1A1A1F);

  /// Dark surface cards.
  static const Color darkSurface = Color(0xFF24272A);

  /// Default border radius for large surfaces.
  static const double radiusLarge = 24;

  /// Default border radius for controls.
  static const double radiusDefault = 12;

  /// Small radius for chips and tags.
  static const double radiusSmall = 8;

  /// Builds the light Material 3 theme.
  static ThemeData light() {
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: primaryBlue,
      brightness: Brightness.light,
      primary: primaryBlue,
      secondary: secondaryOrange,
      surface: lightSurface,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: lightBackground,
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusDefault),
        ),
        color: lightSurface,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(radiusDefault)),
      ),
    );
  }

  /// Builds the dark Material 3 theme.
  static ThemeData dark() {
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: primaryBlue,
      brightness: Brightness.dark,
      primary: primaryBlue,
      secondary: secondaryOrange,
      surface: darkSurface,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: darkBackground,
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusDefault),
        ),
        color: darkSurface,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(radiusDefault)),
      ),
    );
  }
}
