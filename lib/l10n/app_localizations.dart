import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'SuperWeb3Wallet'**
  String get appTitle;

  /// No description provided for @bootstrapReady.
  ///
  /// In en, this message translates to:
  /// **'Wallet shell ready'**
  String get bootstrapReady;

  /// No description provided for @splashLoading.
  ///
  /// In en, this message translates to:
  /// **'Starting…'**
  String get splashLoading;

  /// No description provided for @onboardingCreateWallet.
  ///
  /// In en, this message translates to:
  /// **'Create a New Wallet'**
  String get onboardingCreateWallet;

  /// No description provided for @onboardingImportSrp.
  ///
  /// In en, this message translates to:
  /// **'Import Using Secret Recovery Phrase'**
  String get onboardingImportSrp;

  /// No description provided for @onboardingImportPk.
  ///
  /// In en, this message translates to:
  /// **'Import Using Private Key'**
  String get onboardingImportPk;

  /// No description provided for @onboardingPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get onboardingPrivacyPolicy;

  /// No description provided for @onboardingTermsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get onboardingTermsOfService;

  /// No description provided for @passwordTitle.
  ///
  /// In en, this message translates to:
  /// **'Create password'**
  String get passwordTitle;

  /// No description provided for @passwordFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordFieldLabel;

  /// No description provided for @passwordConfirmLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get passwordConfirmLabel;

  /// No description provided for @passwordStrengthWeak.
  ///
  /// In en, this message translates to:
  /// **'Weak'**
  String get passwordStrengthWeak;

  /// No description provided for @passwordStrengthFair.
  ///
  /// In en, this message translates to:
  /// **'Fair'**
  String get passwordStrengthFair;

  /// No description provided for @passwordStrengthStrong.
  ///
  /// In en, this message translates to:
  /// **'Strong'**
  String get passwordStrengthStrong;

  /// No description provided for @passwordStrengthVeryStrong.
  ///
  /// In en, this message translates to:
  /// **'Very Strong'**
  String get passwordStrengthVeryStrong;

  /// No description provided for @passwordDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'I understand I am responsible for keeping my wallet secure'**
  String get passwordDisclaimer;

  /// No description provided for @passwordContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get passwordContinue;

  /// No description provided for @passwordRequirementHint.
  ///
  /// In en, this message translates to:
  /// **'Min 8 characters with uppercase, number, and special character'**
  String get passwordRequirementHint;

  /// No description provided for @backupTitle.
  ///
  /// In en, this message translates to:
  /// **'Secret Recovery Phrase'**
  String get backupTitle;

  /// No description provided for @backupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Write these words down in order. Never share them.'**
  String get backupSubtitle;

  /// No description provided for @backupToggleShow.
  ///
  /// In en, this message translates to:
  /// **'Show'**
  String get backupToggleShow;

  /// No description provided for @backupToggleHide.
  ///
  /// In en, this message translates to:
  /// **'Hide'**
  String get backupToggleHide;

  /// No description provided for @backupCopy.
  ///
  /// In en, this message translates to:
  /// **'Copy to clipboard'**
  String get backupCopy;

  /// No description provided for @backupCopyUnsafeTitle.
  ///
  /// In en, this message translates to:
  /// **'Unsafe action'**
  String get backupCopyUnsafeTitle;

  /// No description provided for @backupCopyUnsafeBody.
  ///
  /// In en, this message translates to:
  /// **'Copying your phrase is unsafe on shared devices.'**
  String get backupCopyUnsafeBody;

  /// No description provided for @backupWroteDown.
  ///
  /// In en, this message translates to:
  /// **'I wrote it down safely'**
  String get backupWroteDown;

  /// No description provided for @backupContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get backupContinue;

  /// No description provided for @quizTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify phrase'**
  String get quizTitle;

  /// No description provided for @quizSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the missing words'**
  String get quizSubtitle;

  /// No description provided for @quizIncorrect.
  ///
  /// In en, this message translates to:
  /// **'Incorrect, try again'**
  String get quizIncorrect;

  /// No description provided for @quizContinue.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get quizContinue;

  /// No description provided for @quizWordLabel.
  ///
  /// In en, this message translates to:
  /// **'Word {index}'**
  String quizWordLabel(int index);

  /// No description provided for @importSrpTitle.
  ///
  /// In en, this message translates to:
  /// **'Import recovery phrase'**
  String get importSrpTitle;

  /// No description provided for @importSrpPaste.
  ///
  /// In en, this message translates to:
  /// **'Paste phrase'**
  String get importSrpPaste;

  /// No description provided for @importSrpWordsMode.
  ///
  /// In en, this message translates to:
  /// **'Enter words separately'**
  String get importSrpWordsMode;

  /// No description provided for @importSrpPasteMode.
  ///
  /// In en, this message translates to:
  /// **'Paste phrase'**
  String get importSrpPasteMode;

  /// No description provided for @importSrpInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid phrase'**
  String get importSrpInvalid;

  /// No description provided for @importSrpContinue.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get importSrpContinue;

  /// No description provided for @importPkTitle.
  ///
  /// In en, this message translates to:
  /// **'Import private key'**
  String get importPkTitle;

  /// No description provided for @importPkHint.
  ///
  /// In en, this message translates to:
  /// **'64-character hex private key'**
  String get importPkHint;

  /// No description provided for @importPkInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid private key'**
  String get importPkInvalid;

  /// No description provided for @importPkContinue.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get importPkContinue;

  /// No description provided for @importSetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Set wallet password'**
  String get importSetPasswordTitle;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get homeTitle;

  /// No description provided for @homeAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get homeAddress;

  /// No description provided for @legalLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get legalLoading;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// No description provided for @networkWarningTitle.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get networkWarningTitle;

  /// No description provided for @networkWarningOnlySend.
  ///
  /// In en, this message translates to:
  /// **'Only send assets on supported networks.'**
  String get networkWarningOnlySend;

  /// No description provided for @receiveTitle.
  ///
  /// In en, this message translates to:
  /// **'Receive'**
  String get receiveTitle;

  /// No description provided for @actionSend.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get actionSend;

  /// No description provided for @actionReceive.
  ///
  /// In en, this message translates to:
  /// **'Receive'**
  String get actionReceive;

  /// No description provided for @lockTitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock SuperWeb3Wallet'**
  String get lockTitle;

  /// No description provided for @lockSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Authenticate to continue.'**
  String get lockSubtitle;

  /// No description provided for @lockUnlock.
  ///
  /// In en, this message translates to:
  /// **'Unlock with biometrics'**
  String get lockUnlock;

  /// No description provided for @lockReason.
  ///
  /// In en, this message translates to:
  /// **'Unlock your wallet'**
  String get lockReason;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
