import '../../../../../errors/errors.dart';
import '../../../../../l10n/generated/l10n.dart';

/// {@template firebase_sign_in_failure}
/// Thrown during the login process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithCredential.html
/// {@endtemplate}
class FirebaseSignInFailure implements Failure {
  @override
  final String message;

  /// {@macro firebase_sign_in_failure}
  FirebaseSignInFailure({String? message})
      : message = message ?? AppLocalizations.current.unknowError;

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory FirebaseSignInFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential:':
        return FirebaseSignInFailure(
          message: AppLocalizations.current.thereIsAnotherAccount,
        );
      case 'invalid-credential':
        return FirebaseSignInFailure(
          message: AppLocalizations.current.credentialIsInvalid,
        );
      case 'invalid-verification-code':
        return FirebaseSignInFailure(
          message: AppLocalizations.current.verificationCodeIsInvalid,
        );
      case 'invalid-verification-id':
        return FirebaseSignInFailure(
          message: AppLocalizations.current.verificationIdIsInvalid,
        );
      case 'operation-not-allowed':
        return FirebaseSignInFailure(
          message: AppLocalizations.current.cantCreateAccountWithMethod,
        );
      case 'invalid-email':
        return FirebaseSignInFailure(
          message: AppLocalizations.current.emailIsInvalid,
        );
      case 'user-disabled':
        return FirebaseSignInFailure(
          message: AppLocalizations.current.userHasBeenDisabled,
        );
      case 'user-not-found':
        return FirebaseSignInFailure(
          message: AppLocalizations.current.emailWasNotFound,
        );
      case 'wrong-password':
        return FirebaseSignInFailure(
          message: AppLocalizations.current.incorrectEmailOrPassword,
        );
      default:
        return FirebaseSignInFailure();
    }
  }
}
