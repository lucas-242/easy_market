import 'package:market_lists/app/core/errors/errors.dart';

/// {@template firebase_sign_in_failure}
/// Thrown during the login process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithCredential.html
/// {@endtemplate}
class FirebaseSignInFailure implements Failure {
  @override
  final String message;

  /// {@macro firebase_sign_in_failure}
  FirebaseSignInFailure({this.message = 'An unknown exception occurred.'});

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory FirebaseSignInFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential:':
        return FirebaseSignInFailure(
          message: 'There is already an account with this credential.',
        );
      case 'invalid-credential':
        return FirebaseSignInFailure(
          message: 'The credential is invalid.',
        );
      case 'invalid-verification-code':
        return FirebaseSignInFailure(
          message: 'The verification code entered is not valid.',
        );
      case 'invalid-verification-id':
        return FirebaseSignInFailure(
          message: 'The verification ID entered is not valid.',
        );
      case 'operation-not-allowed':
        return FirebaseSignInFailure(
          message:
              'You can not create an account with this method. Please try another account or contact support for help.',
        );
      case 'invalid-email':
        return FirebaseSignInFailure(
          message: 'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return FirebaseSignInFailure(
          message:
              'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return FirebaseSignInFailure(
          message: 'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return FirebaseSignInFailure(
          message: 'Incorrect password, please try again.',
        );
      default:
        return FirebaseSignInFailure();
    }
  }
}
