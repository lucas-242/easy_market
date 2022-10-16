import '../../../../../l10n/generated/l10n.dart';

import '../../../../../errors/errors.dart';

/// {@template firebase_reset_password_failure}
/// Thrown during the sign up process if a failure occurs.
/// {@endtemplate}
class FirebaseResetPasswordFailure implements Failure {
  @override
  final String message;

  /// {@macro firebase_reset_password_failure}
  FirebaseResetPasswordFailure({String? message})
      : message = message ?? AppLocalizations.current.unknowError;

  /// Create an authentication message
  /// from a firebase reset password exception code.
  factory FirebaseResetPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'expired-action-code:':
        return FirebaseResetPasswordFailure(
          message: AppLocalizations.current.linkHasExpired,
        );
      case 'invalid-action-code':
        return FirebaseResetPasswordFailure(
          message: AppLocalizations.current.linkHasBeenUsed,
        );
      case 'weak-password':
        return FirebaseResetPasswordFailure(
          message: AppLocalizations.current.passwordIsWeak,
        );
      case 'invalid-email':
        return FirebaseResetPasswordFailure(
          message: AppLocalizations.current.emailIsInvalid,
        );
      case 'user-disabled':
        return FirebaseResetPasswordFailure(
          message: AppLocalizations.current.userHasBeenDisabled,
        );
      case 'user-not-found':
        return FirebaseResetPasswordFailure(
          message: AppLocalizations.current.emailWasNotFound,
        );
      default:
        return FirebaseResetPasswordFailure();
    }
  }
}
