import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:superweb3wallet/core/utils/password_strength.dart';
import 'package:superweb3wallet/domain/repositories/wallet_repository.dart';
import 'package:superweb3wallet/l10n/app_localizations.dart';
import 'package:superweb3wallet/presentation/blocs/create_password/create_password_cubit.dart';
import 'package:superweb3wallet/presentation/models/import_kind.dart';
import 'package:superweb3wallet/presentation/screens/home/wallet_home_screen.dart';

/// Collects password for imported credentials before persisting encrypted keys.
class ImportPasswordScreen extends StatelessWidget {
  /// Route path for import password entry.
  static const String routePath = '/import/password';

  /// Named route identifier.
  static const String routeName = 'importPassword';

  /// Creates import password UI; expects [ImportKind] via [GoRouter.extra].
  const ImportPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ImportKind kind = GoRouterState.of(context).extra! as ImportKind;
    return BlocProvider<CreatePasswordCubit>(
      create: (_) => CreatePasswordCubit(const PasswordStrengthEvaluator()),
      child: _ImportPasswordBody(importKind: kind),
    );
  }
}

class _ImportPasswordBody extends StatelessWidget {
  const _ImportPasswordBody({required this.importKind});

  final ImportKind importKind;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.importSetPasswordTitle)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<CreatePasswordCubit, CreatePasswordState>(
          builder: (BuildContext context, CreatePasswordState state) {
            final CreatePasswordCubit cubit = context.read<CreatePasswordCubit>();
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
                CheckboxListTile(
                  value: state.accepted,
                  onChanged: (bool? v) => cubit.toggleAccepted(v ?? false),
                  title: Text(l10n.passwordDisclaimer),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: canSubmit
                      ? () async {
                          final WalletRepository repo =
                              context.read<WalletRepository>();
                          final String password = state.password;
                          if (importKind is ImportKindMnemonic) {
                            final ImportKindMnemonic m =
                                importKind as ImportKindMnemonic;
                            await repo.importMnemonic(
                              mnemonic: m.mnemonic,
                              password: password,
                            );
                          } else if (importKind is ImportKindPrivateKey) {
                            final ImportKindPrivateKey p =
                                importKind as ImportKindPrivateKey;
                            await repo.importPrivateKey(
                              hexPrivateKey: p.hexKey,
                              password: password,
                            );
                          }
                          if (context.mounted) {
                            context.go(WalletHomeScreen.routePath);
                          }
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
}
