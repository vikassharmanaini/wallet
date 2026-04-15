import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superweb3wallet/core/utils/password_strength.dart';

/// UI state for the create/import password form.
class CreatePasswordState extends Equatable {
  /// Creates immutable password form state.
  const CreatePasswordState({
    this.password = '',
    this.confirm = '',
    this.accepted = false,
  });

  /// Primary password field value.
  final String password;

  /// Confirmation field value.
  final String confirm;

  /// Whether the user accepted the responsibility disclaimer.
  final bool accepted;

  /// True when password policy passes and fields match and disclaimer checked.
  bool canSubmit(PasswordStrengthEvaluator evaluator) {
    return evaluator.meetsPolicy(password) &&
        password == confirm &&
        accepted;
  }

  /// Strength label for the current password (may be invalid).
  PasswordStrength strength(PasswordStrengthEvaluator evaluator) {
    return evaluator.strength(password);
  }

  @override
  List<Object?> get props => <Object?>[password, confirm, accepted];
}

/// Cubit managing password entry for wallet creation.
class CreatePasswordCubit extends Cubit<CreatePasswordState> {
  /// Creates cubit with the shared [evaluator] rules.
  CreatePasswordCubit(this._evaluator) : super(const CreatePasswordState());

  final PasswordStrengthEvaluator _evaluator;

  /// Updates the primary password field.
  void passwordChanged(String value) {
    emit(
      CreatePasswordState(
        password: value,
        confirm: state.confirm,
        accepted: state.accepted,
      ),
    );
  }

  /// Updates the confirmation field.
  void confirmChanged(String value) {
    emit(
      CreatePasswordState(
        password: state.password,
        confirm: value,
        accepted: state.accepted,
      ),
    );
  }

  /// Updates the responsibility checkbox.
  void toggleAccepted(bool value) {
    emit(
      CreatePasswordState(
        password: state.password,
        confirm: state.confirm,
        accepted: value,
      ),
    );
  }

  /// Exposes evaluator for widgets.
  PasswordStrengthEvaluator get evaluator => _evaluator;
}
