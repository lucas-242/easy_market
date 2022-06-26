import 'package:market_lists/app/core/auth/domain/errors/errors.dart';

/// {@template log_in_with_email_and_password_failure}
/// Thrown during the login process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithEmailAndPassword.html
/// {@endtemplate}
class FirebaseSignInWithEmailFailure extends SignInWithEmailFailure {
  /// {@macro log_in_with_email_and_password_failure}
  FirebaseSignInWithEmailFailure(
      {String message = 'An unknown exception occurred.'})
      : super(message);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory FirebaseSignInWithEmailFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return FirebaseSignInWithEmailFailure(
          message: 'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return FirebaseSignInWithEmailFailure(
          message:
              'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return FirebaseSignInWithEmailFailure(
          message: 'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return FirebaseSignInWithEmailFailure(
          message: 'Incorrect password, please try again.',
        );
      default:
        return FirebaseSignInWithEmailFailure();
    }
  }
}
