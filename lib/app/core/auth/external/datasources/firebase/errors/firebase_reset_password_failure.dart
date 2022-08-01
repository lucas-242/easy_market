import '../../../../../errors/errors.dart';

/// {@template firebase_reset_password_failure}
/// Thrown during the sign up process if a failure occurs.
/// {@endtemplate}
class FirebaseResetPasswordFailure implements Failure {
  @override
  final String message;

  /// {@macro firebase_reset_password_failure}
  FirebaseResetPasswordFailure(
      {this.message = 'An unknown exception occurred.'});

  /// Create an authentication message
  /// from a firebase reset password exception code.
  factory FirebaseResetPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'expired-action-code:':
        return FirebaseResetPasswordFailure(
          message: 'The link has expired.',
        );
      case 'invalid-action-code':
        return FirebaseResetPasswordFailure(
          message: 'The link has already been used.',
        );
      case 'weak-password':
        return FirebaseResetPasswordFailure(
          message: 'Password is too weak. Please, try a different one.',
        );
      case 'invalid-email':
        return FirebaseResetPasswordFailure(
          message: 'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return FirebaseResetPasswordFailure(
          message:
              'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return FirebaseResetPasswordFailure(
          message: 'Email was not found, please create an account.',
        );
      default:
        return FirebaseResetPasswordFailure();
    }
  }
}
