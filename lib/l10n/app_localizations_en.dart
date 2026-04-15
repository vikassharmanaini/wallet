// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'SuperWeb3Wallet';

  @override
  String get bootstrapReady => 'Wallet shell ready';

  @override
  String get splashLoading => 'Starting…';

  @override
  String get onboardingCreateWallet => 'Create a New Wallet';

  @override
  String get onboardingImportSrp => 'Import Using Secret Recovery Phrase';

  @override
  String get onboardingImportPk => 'Import Using Private Key';

  @override
  String get onboardingPrivacyPolicy => 'Privacy Policy';

  @override
  String get onboardingTermsOfService => 'Terms of Service';

  @override
  String get passwordTitle => 'Create password';

  @override
  String get passwordFieldLabel => 'Password';

  @override
  String get passwordConfirmLabel => 'Confirm password';

  @override
  String get passwordStrengthWeak => 'Weak';

  @override
  String get passwordStrengthFair => 'Fair';

  @override
  String get passwordStrengthStrong => 'Strong';

  @override
  String get passwordStrengthVeryStrong => 'Very Strong';

  @override
  String get passwordDisclaimer =>
      'I understand I am responsible for keeping my wallet secure';

  @override
  String get passwordContinue => 'Continue';

  @override
  String get passwordRequirementHint =>
      'Min 8 characters with uppercase, number, and special character';

  @override
  String get backupTitle => 'Secret Recovery Phrase';

  @override
  String get backupSubtitle =>
      'Write these words down in order. Never share them.';

  @override
  String get backupToggleShow => 'Show';

  @override
  String get backupToggleHide => 'Hide';

  @override
  String get backupCopy => 'Copy to clipboard';

  @override
  String get backupCopyUnsafeTitle => 'Unsafe action';

  @override
  String get backupCopyUnsafeBody =>
      'Copying your phrase is unsafe on shared devices.';

  @override
  String get backupWroteDown => 'I wrote it down safely';

  @override
  String get backupContinue => 'Continue';

  @override
  String get quizTitle => 'Verify phrase';

  @override
  String get quizSubtitle => 'Enter the missing words';

  @override
  String get quizIncorrect => 'Incorrect, try again';

  @override
  String get quizContinue => 'Verify';

  @override
  String quizWordLabel(int index) {
    return 'Word $index';
  }

  @override
  String get importSrpTitle => 'Import recovery phrase';

  @override
  String get importSrpPaste => 'Paste phrase';

  @override
  String get importSrpWordsMode => 'Enter words separately';

  @override
  String get importSrpPasteMode => 'Paste phrase';

  @override
  String get importSrpInvalid => 'Invalid phrase';

  @override
  String get importSrpContinue => 'Import';

  @override
  String get importPkTitle => 'Import private key';

  @override
  String get importPkHint => '64-character hex private key';

  @override
  String get importPkInvalid => 'Invalid private key';

  @override
  String get importPkContinue => 'Import';

  @override
  String get importSetPasswordTitle => 'Set wallet password';

  @override
  String get homeTitle => 'Wallet';

  @override
  String get homeAddress => 'Address';

  @override
  String get legalLoading => 'Loading…';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonOk => 'OK';

  @override
  String get networkWarningTitle => 'Security';

  @override
  String get networkWarningOnlySend =>
      'Only send assets on supported networks.';

  @override
  String get receiveTitle => 'Receive';

  @override
  String get actionSend => 'Send';

  @override
  String get actionReceive => 'Receive';

  @override
  String get lockTitle => 'Unlock SuperWeb3Wallet';

  @override
  String get lockSubtitle => 'Authenticate to continue.';

  @override
  String get lockUnlock => 'Unlock with biometrics';

  @override
  String get lockReason => 'Unlock your wallet';

  @override
  String get homeAccountName => 'Account 1';

  @override
  String get homeBalanceUsd => 'Total balance';

  @override
  String get homeChange24h => '24h change';

  @override
  String get actionBuy => 'Buy';

  @override
  String get actionSwap => 'Swap';

  @override
  String get actionBridge => 'Bridge';

  @override
  String get tabTokens => 'Tokens';

  @override
  String get tabNfts => 'NFTs';

  @override
  String get tabActivity => 'Activity';

  @override
  String get tabDeFi => 'DeFi';

  @override
  String get deFiComingSoon => 'DeFi integrations are coming soon.';

  @override
  String get tokensEmpty => 'No tokens yet';

  @override
  String get nftsEmpty => 'No NFTs yet';

  @override
  String get activityEmpty => 'No activity yet';

  @override
  String get networkPickerTitle => 'Select network';

  @override
  String get sendTitle => 'Send';

  @override
  String receiveHint(String symbol, String network) {
    return 'Only send $symbol on $network';
  }

  @override
  String get accountsTitle => 'Accounts';

  @override
  String get swapTitle => 'Swap';

  @override
  String get bridgeTitle => 'Bridge';

  @override
  String get buyTitle => 'Buy';

  @override
  String get browserTitle => 'Browser';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get signPersonalTitle => 'Sign message';

  @override
  String get signTxTitle => 'Confirm transaction';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsNotificationsStub =>
      'Local notifications will appear here.';
}
