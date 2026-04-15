/// Password strength bucket used by the create-password UI.
enum PasswordStrength {
  /// Does not meet minimum policy.
  invalid,

  /// Meets policy but is weak entropy.
  weak,

  /// Acceptable entropy.
  fair,

  /// Good entropy.
  strong,

  /// Excellent entropy.
  veryStrong,
}

/// Evaluates password policy and rough strength for UI indicators.
class PasswordStrengthEvaluator {
  /// Creates evaluator with default complexity rules.
  const PasswordStrengthEvaluator();

  static final RegExp _upper = RegExp(r'[A-Z]');
  static final RegExp _lower = RegExp(r'[a-z]');
  static final RegExp _digit = RegExp(r'[0-9]');
  static final RegExp _special = RegExp(r'[^A-Za-z0-9]');

  /// Returns true when password meets minimum complexity rules.
  bool meetsPolicy(String password) {
    if (password.length < 8) {
      return false;
    }
    return _upper.hasMatch(password) &&
        _digit.hasMatch(password) &&
        _special.hasMatch(password);
  }

  /// Returns a strength label for a password that already meets policy.
  PasswordStrength strength(String password) {
    if (!meetsPolicy(password)) {
      return PasswordStrength.invalid;
    }
    int score = 0;
    if (password.length >= 12) {
      score++;
    }
    if (password.length >= 16) {
      score++;
    }
    if (_lower.hasMatch(password) && _upper.hasMatch(password)) {
      score++;
    }
    if (_special.hasMatch(password) && password.length >= 10) {
      score++;
    }
    if (password.length >= 20) {
      score++;
    }
    if (score <= 1) {
      return PasswordStrength.weak;
    }
    if (score == 2) {
      return PasswordStrength.fair;
    }
    if (score == 3) {
      return PasswordStrength.strong;
    }
    return PasswordStrength.veryStrong;
  }
}
