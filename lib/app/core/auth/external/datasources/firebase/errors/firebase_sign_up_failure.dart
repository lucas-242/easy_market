import '../../../../../errors/errors.dart';
import '../../../../../l10n/generated/l10n.dart';

/// {@template firebase_sign_up_failure}
/// Thrown during the sign up process if a failure occurs.
/// {@endtemplate}
class FirebaseSignUpFailure implements Failure {
  @override
  final String message;

  /// {@macro firebase_sign_up_failure}
  FirebaseSignUpFailure({String? message})
      : message = message ?? AppLocalizations.current.unknowError;

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory FirebaseSignUpFailure.fromCode(String code) {
    switch (code) {
      case 'email-already-in-use:':
        return FirebaseSignUpFailure(
          message: AppLocalizations.current.thereIsAnotherAccount,
        );
      case 'operation-not-allowed':
        return FirebaseSignUpFailure(
          message: AppLocalizations.current.cantCreateAccountWithMethod,
        );
      case 'invalid-email':
        return FirebaseSignUpFailure(
          message: AppLocalizations.current.emailIsInvalid,
        );
      case 'weak-password':
        return FirebaseSignUpFailure(
          message: AppLocalizations.current.passwordIsWeak,
        );
      default:
        return FirebaseSignUpFailure();
    }
  }
}
