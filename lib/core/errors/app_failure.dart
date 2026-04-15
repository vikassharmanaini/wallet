import 'package:equatable/equatable.dart';

/// User-visible or loggable failure in the domain/data layers.
class AppFailure extends Equatable {
  /// Creates a failure with a stable [code] and human [message] key for l10n.
  const AppFailure({required this.code, required this.messageKey});

  /// Machine-readable failure code (snake_case).
  final String code;

  /// ARB lookup key or developer message key for localization.
  final String messageKey;

  @override
  List<Object?> get props => <Object?>[code, messageKey];
}
