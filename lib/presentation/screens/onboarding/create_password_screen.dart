import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:superweb3wallet/core/utils/password_strength.dart';
import 'package:superweb3wallet/domain/usecases/generate_mnemonic_usecase.dart';
import 'package:superweb3wallet/l10n/app_localizations.dart';
import 'package:superweb3wallet/presentation/blocs/create_password/create_password_cubit.dart';
import 'package:superweb3wallet/presentation/models/wallet_creation_args.dart';
import 'package:superweb3wallet/presentation/screens/onboarding/backup_phrase_screen.dart';

/// Step 1 of wallet creation: password policy, strength meter, disclaimer.
class CreatePasswordScreen extends StatelessWidget {
  /// Route path for password creation.
  static const String routePath = '/create-wallet/password';

  /// Named route identifier.
  static const String routeName = 'createPassword';

  /// Creates screen with its own [CreatePasswordCubit].
  const CreatePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreatePasswordCubit>(
      create: (_) => CreatePasswordCubit(const PasswordStrengthEvaluator()),
      child: const _CreatePasswordView(),
    );
  }
}

class _CreatePasswordView extends StatelessWidget {
  const _CreatePasswordView();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.passwordTitle)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<CreatePasswordCubit, CreatePasswordState>(
          builder: (BuildContext context, CreatePasswordState state) {
            final CreatePasswordCubit cubit = context.read<CreatePasswordCubit>();
            final PasswordStrength strength = state.strength(cubit.evaluator);
            final bool canSubmit = state.canSubmit(cubit.evaluator);
            return ListView(
              children: <Widget>[
                Text(
                  l10n.passwordRequirementHint,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 12),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: l10n.passwordFieldLabel),
                  onChanged: cubit.passwordChanged,
                ),
                const SizedBox(height: 12),
                TextField(
                  obscureText: true,
                  decoration:
                      InputDecoration(labelText: l10n.passwordConfirmLabel),
                  onChanged: cubit.confirmChanged,
                ),
                const SizedBox(height: 12),
                _StrengthBar(
                  strength: strength,
                  meetsPolicy: cubit.evaluator.meetsPolicy(state.password),
                ),
                const SizedBox(height: 8),
                Text(_strengthLabel(l10n, strength)),
                const SizedBox(height: 12),
                CheckboxListTile(
                  value: state.accepted,
                  onChanged: (bool? v) => cubit.toggleAccepted(v ?? false),
                  title: Text(l10n.passwordDisclaimer),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: canSubmit
                      ? () {
                          final String password = state.password;
                          const GenerateMnemonicUseCase gen =
                              GenerateMnemonicUseCase();
                          final String phrase = gen();
                          final List<String> words = phrase.split(' ');
                          context.push(
                            BackupPhraseScreen.routePath,
                            extra: WalletCreationArgs(
                              password: password,
                              mnemonicWords: words,
                            ),
                          );
                        }
                      : null,
                  child: Text(l10n.passwordContinue),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  static String _strengthLabel(
    AppLocalizations l10n,
    PasswordStrength strength,
  ) {
    switch (strength) {
      case PasswordStrength.invalid:
        return '';
      case PasswordStrength.weak:
        return l10n.passwordStrengthWeak;
      case PasswordStrength.fair:
        return l10n.passwordStrengthFair;
      case PasswordStrength.strong:
        return l10n.passwordStrengthStrong;
      case PasswordStrength.veryStrong:
        return l10n.passwordStrengthVeryStrong;
    }
  }
}

class _StrengthBar extends StatelessWidget {
  const _StrengthBar({
    required this.strength,
    required this.meetsPolicy,
  });

  final PasswordStrength strength;
  final bool meetsPolicy;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    double value = 0;
    Color color = scheme.outline;
    if (meetsPolicy) {
      switch (strength) {
        case PasswordStrength.invalid:
          value = 0;
        case PasswordStrength.weak:
          value = 0.25;
          color = scheme.error;
        case PasswordStrength.fair:
          value = 0.5;
          color = scheme.tertiary;
        case PasswordStrength.strong:
          value = 0.75;
          color = scheme.primary;
        case PasswordStrength.veryStrong:
          value = 1;
          color = scheme.secondary;
      }
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: LinearProgressIndicator(
        value: meetsPolicy ? value : 0,
        minHeight: 8,
        color: color,
        backgroundColor: scheme.surfaceContainerHighest,
      ),
    );
  }
}
